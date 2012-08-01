Return-Path: <cyrus@holtmann.org>
From: Peng Chen <pengchen@qca.qualcomm.com>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Peng Chen <pengchen@qca.qualcomm.com>
Subject: [PATCH] Add support for downloading binary patch.
Date: Wed, 1 Aug 2012 10:42:18 +0800
Message-ID: <1343788938-7420-1-git-send-email-pengchen@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hciattach_ath3k.c |  133 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 115 insertions(+), 18 deletions(-)

diff --git a/tools/hciattach_ath3k.c b/tools/hciattach_ath3k.c
index 23208c6..ec39f5e 100644
--- a/tools/hciattach_ath3k.c
+++ b/tools/hciattach_ath3k.c
@@ -498,6 +498,31 @@ static int set_patch_ram(int dev, char *patch_loc, int len)
 	return err;
 }
 
+static int set_patch_ram_dfu(int dev, unsigned int addr)
+{
+	int err;
+	uint8_t cmd[20];
+	uint8_t *event;
+	uint8_t *loc_ptr = &cmd[7];
+
+	load_hci_ps_hdr(cmd, SET_PATCH_RAM_ID, ADDRESS_LEN, 0);
+
+	loc_ptr[0] = (unsigned char)(addr & 0xff);
+	loc_ptr[1] = (unsigned char)((addr >> 8) & 0xff);
+	loc_ptr[2] = (unsigned char)((addr >> 16) & 0xff);
+	loc_ptr[3] = (unsigned char)((addr >> 24) & 0xff);
+
+	err = send_hci_cmd_sync(dev, cmd, SET_PATCH_RAM_CMD_SIZE, &event);
+	if (err < 0)
+		return err;
+
+	err = read_ps_event(event, HCI_PS_CMD_OCF);
+
+	free(event);
+
+	return err;
+}
+
 #define PATCH_LOC_KEY    "DA:"
 #define PATCH_LOC_STRING_LEN    8
 static int ps_patch_download(int fd, FILE *stream)
@@ -559,6 +584,60 @@ static int ps_patch_download(int fd, FILE *stream)
 	return patch_count;
 }
 
+struct ATHDFU_FILEHDR {
+	uint32_t AF_WriteAddr;   /* download the file to af_write_addr */
+	uint32_t AF_EntryAddr;   /* the application program's entry address */
+	uint32_t AF_FileLength;  /* the application program's length */
+	uint32_t AF_FileCRC;     /* crc the application */
+	uint32_t AF_FileType;    /* the file type */
+};
+
+#define DFU_GAP 12
+
+static int ps_patch_download_dfu(int fd, FILE *stream)
+{
+	struct ATHDFU_FILEHDR dfu_hdr;
+	uint8_t dfu_gap[DFU_GAP];
+	int byte_cnt = 0;
+	int patch_count = 0;
+
+	if ((fread((uint8_t *)&dfu_hdr, 1, sizeof(dfu_hdr), stream))
+			< sizeof(dfu_hdr))
+		return -1;
+	set_patch_ram_dfu(fd, dfu_hdr.AF_WriteAddr);
+
+	if ((fread(dfu_gap, 1, DFU_GAP, stream)) < DFU_GAP)
+		return -1;
+
+	byte_cnt = dfu_hdr.AF_FileLength - DFU_GAP;
+
+	while (byte_cnt > 0) {
+		uint8_t cmd[HCI_MAX_CMD_SIZE];
+		struct patch_entry patch;
+
+		if (byte_cnt > MAX_PATCH_CMD)
+			patch.len = MAX_PATCH_CMD;
+		else
+			patch.len = byte_cnt;
+
+		if ((fread(patch.data, 1, patch.len, stream))
+				< (uint16_t)patch.len)
+			return -1;
+
+		load_hci_ps_hdr(cmd, WRITE_PATCH, patch.len, patch_count);
+		memcpy(&cmd[HCI_PS_CMD_HDR_LEN], patch.data, patch.len);
+
+		if (write_cmd(fd, cmd, patch.len + HCI_PS_CMD_HDR_LEN) < 0)
+			return -1;
+
+		patch_count++;
+		byte_cnt = byte_cnt - patch.len;
+	}
+
+	if (write_ps_cmd(fd, ENABLE_PATCH, 0) < 0)
+		return -1;
+	return 1;
+}
 #define PS_RAM_SIZE 2048
 
 static int ps_config_download(int fd, int tag_count)
@@ -588,19 +667,31 @@ static void get_ps_file_name(uint32_t devtype, uint32_t rom_version,
 	snprintf(path, MAXPATHLEN, "%s%x/%s", FW_PATH, rom_version, filename);
 }
 
-#define PATCH_FILE        "RamPatch.txt"
+#define TXT_PATCH_FILE        "RamPatch.txt"
+#define DFU_PATCH_FILE        "AthrBT_0x0"
 #define FPGA_ROM_VERSION  0x99999999
 #define ROM_DEV_TYPE      0xdeadc0de
 
-static void get_patch_file_name(uint32_t dev_type, uint32_t rom_version,
-				uint32_t build_version, char *path)
+static void get_file_name_of_patch_in_txt_format(uint32_t dev_type,
+		uint32_t rom_version, uint32_t build_version, char *path)
 {
 	if (rom_version == FPGA_ROM_VERSION && dev_type != ROM_DEV_TYPE &&
 					dev_type != 0 && build_version == 1)
 		path[0] = '\0';
 	else
 		snprintf(path, MAXPATHLEN, "%s%x/%s",
-				FW_PATH, rom_version, PATCH_FILE);
+				FW_PATH, rom_version, TXT_PATCH_FILE);
+}
+
+static void get_file_name_of_patch_in_dfu_format(uint32_t dev_type,
+		uint32_t rom_version, uint32_t build_version, char *path)
+{
+	if (rom_version == FPGA_ROM_VERSION && dev_type != ROM_DEV_TYPE &&
+					dev_type != 0 && build_version == 1)
+		path[0] = '\0';
+	else
+		snprintf(path, MAXPATHLEN, "%s%s%x.dfu",
+				FW_PATH, DFU_PATCH_FILE, rom_version);
 }
 
 #define VERIFY_CRC   9
@@ -798,7 +889,8 @@ static int ath_ps_download(int fd)
 	uint32_t rom_version = 0;
 	uint32_t build_version = 0;
 	uint32_t dev_type = 0;
-	char patch_file[PATH_MAX];
+	char patch_file_in_txt_fmt[PATH_MAX];
+	char patch_file_in_dfu_fmt[PATH_MAX];
 	char ps_file[PATH_MAX];
 	FILE *stream;
 
@@ -823,7 +915,10 @@ static int ath_ps_download(int fd)
 	}
 
 	get_ps_file_name(dev_type, rom_version, ps_file);
-	get_patch_file_name(dev_type, rom_version, build_version, patch_file);
+	get_file_name_of_patch_in_txt_format(dev_type, rom_version,
+			build_version, patch_file_in_txt_fmt);
+	get_file_name_of_patch_in_dfu_format(dev_type, rom_version,
+			build_version, patch_file_in_dfu_fmt);
 
 	stream = fopen(ps_file, "r");
 	if (!stream) {
@@ -844,20 +939,22 @@ static int ath_ps_download(int fd)
 	 * It is not necessary that Patch file be available,
 	 * continue with PS Operations if patch file is not available.
 	 */
-	if (patch_file[0] == '\0')
-		err = 0;
-
-	stream = fopen(patch_file, "r");
-	if (!stream)
-		err = 0;
-	else {
-		patch_count = ps_patch_download(fd, stream);
+	stream = fopen(patch_file_in_dfu_fmt, "r");
+	if (patch_file_in_dfu_fmt[0] != '\0' && stream) {
+		patch_count = ps_patch_download_dfu(fd, stream);
 		fclose(stream);
-
-		if (patch_count < 0) {
-			err = -EILSEQ;
-			goto download_cmplete;
+	} else if (patch_file_in_txt_fmt[0] != '\0') {
+		stream = fopen(patch_file_in_txt_fmt, "r");
+		if (stream) {
+			patch_count = ps_patch_download(fd, stream);
+			fclose(stream);
 		}
+	} else
+		err = 0;
+
+	if (patch_count < 0) {
+		err = -EILSEQ;
+		goto download_cmplete;
 	}
 
 	err = ps_config_download(fd, tag_count);
-- 
1.7.9.5
