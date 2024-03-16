Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53453FC2
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Mar 2024 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550189; cv=none; b=gSzLp5ATpEYQfK3rd84HoZ6/wMJBIpJaPYgvRoN6+kVF2xzDDJHsnFxWPc9lE5pn8Zl+KpKCjRo8S7N+/mZc838vSuKnKlTtb+b05XGfw9mUJR30CuIwUXYyCf8E1mnQs9yb6kcY8kutrcib2iv0qfWsZ+AjWj2SN6eL37utaLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550189; c=relaxed/simple;
	bh=KPBCGOlo92oySGJ/YMElzESDv4SEQx3+JOTMi0xyGsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Si+taRTOi9DfqApY7gbDTXulY9AIzlfpJOauqrQPYJUimd4SLNwk1S1TMlDHHr2/hMgi1JD+xRawYjCAOSgNFLhnGI2WgSUfxKbe3S6rFMgpEnkLaC37ye3UCODgpJLsQyhG3wkmAe7C+1QUJqYI1qaq9vM3ARXm5s4Akx39iVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AoCnwVv7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AoCnwVv7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710550187; x=1742086187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KPBCGOlo92oySGJ/YMElzESDv4SEQx3+JOTMi0xyGsU=;
  b=AoCnwVv7nwArCvV3kyVq06EbdNu/nbtRDbhKN/bg2eENLRo6r8xi7Pb+
   YX4qwXO6otHzngZNFfif7ELA/++rcV8E/31Zpbciq0uzRHk89LFRXiScR
   J6FgnsBw8vkOEnX69PRaL2QbpZPTHQ7pfyt+CL0ITmwQEtZU/4I1fbwkX
   R22khmKa5i95f1TrfoWc8+M/9LrG4gKlOE5RhpMPOC/nQi2yoN1lQijek
   IK3aFcTLWwlZG1Z//ttTjCeXaBpDVeNNuwtkut9D69vF8/xb7Z3JxdzET
   QFhDbzadjmOs7s337mHwiDKEr9RxHSiiRawD+6j2rwhSLIukYwYseJJ9r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="8382690"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="8382690"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 17:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="12910660"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa008.fm.intel.com with ESMTP; 15 Mar 2024 17:49:44 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] monitor/intel: Add decode support for vendor command 0xfc2a
Date: Sat, 16 Mar 2024 06:33:27 +0530
Message-Id: <20240316010327.944183-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

0xfc2a command is used to read the connection information by bdaddress.

btmon output:

< HCI Command: Intel Read Connection Info by bd address (0x3f|0x002a) plen 7
        Device Address Type: Random Device Address (0x01)
        Address: CF:AC:A6:79:3C:AF (OUI CF-AC-A6)
        af 3c 79 a6 ac cf
> HCI Event: Command Complete (0x0e) plen 9
      Intel Read Connection Info by bd address (0x3f|0x002a) ncmd 1
        Status: Success (0x00)
        Number of handles: 0x01
        Handle: 3585
        State: Connection is established on this handle (0x06)
        Type: Handle belongs to LE link (0x04)
---
 monitor/intel.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/monitor/intel.c b/monitor/intel.c
index aa05a803bf8e..d50f70779459 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -534,6 +534,109 @@ static void manufacturer_mode_cmd(uint16_t index, const void *data,
 	print_field("Reset behavior: %s (0x%2.2x)", str, reset);
 }
 
+static void read_connection_info_cmd(uint16_t index, const void *data,
+				     uint8_t size)
+{
+	uint8_t addr_type;
+	const char *str;
+
+	addr_type = get_u8(data);
+
+	switch (addr_type) {
+	case 0x00:
+		str = "Public Device Address";
+		break;
+	case 0x01:
+		str = "Random Device Address";
+		break;
+	default:
+		str = "Unknown Device Address";
+		break;
+	}
+	print_field("Device Address Type: %s (0x%2.2x)", str, addr_type);
+	packet_print_addr("Address", data + 1, 0x00);
+	packet_hexdump(data + 1, 6);
+
+}
+
+static void read_connection_info_rsp(uint16_t index, const void *data,
+				     uint8_t size)
+{
+	uint8_t status = get_u8(data);
+	uint8_t hndls;
+	const uint8_t *p;
+	const char *str;
+	uint8_t i;
+
+	print_status(status);
+
+	if (status)
+		return;
+	size--;
+
+	hndls = get_u8(data + 1);
+	print_field("Number of handles: 0x%2.2x", hndls);
+	size--;
+
+	for (i = 0, p = data + 2; size > 0 && i < hndls;
+			size -= 4, i++, p = p + 4) {
+		uint16_t handle = get_le16(p);
+		uint8_t state = get_u8(p + 2);
+		uint8_t type = get_u8(p + 3);
+
+		print_field("Handle: %u", handle);
+		switch (state) {
+		case 1:
+			str = "Connection is detached but handle is not yet released";
+			break;
+		case 2:
+			str = "Connection is used for outgoing remote name request";
+			break;
+		case 4:
+			str = "Connection is prepared  but handle is not yet sent to host";
+			break;
+		case 5:
+			str = "Connection request is pending to the host on this handle";
+			break;
+		case 6:
+			str = "Connection is established on this handle";
+			break;
+		case 7:
+			str = "Connection is in Hold mode";
+			break;
+		case 8:
+			str = "Connection in Sniff mode";
+			break;
+		default:
+			str = "Unknown state";
+			break;
+		}
+
+		print_field("State: %s (0x%2.2x)", str, state);
+		switch (type) {
+		case 0:
+			str = "Handle belongs to SCO link";
+			break;
+		case 1:
+			str = "Handle belongs to ACL link";
+			break;
+		case 2:
+			str = "Handle belongs to eSCO link";
+			break;
+		case 4:
+			str  = "Handle belongs to LE link";
+			break;
+		case 255:
+			str = "Handle doesn't have an associated link";
+			break;
+		default:
+			str = "Unknown link";
+			break;
+		}
+		print_field("Type: %s (0x%2.2x)", str, type);
+	}
+}
+
 static void write_bd_data_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	uint8_t features[8];
@@ -763,6 +866,9 @@ static const struct vendor_ocf vendor_ocf_table[] = {
 	{ 0x012, "Read Link RSSI" },
 	{ 0x022, "Get Exception Info" },
 	{ 0x024, "Clear Exception Info" },
+	{ 0x02a, "Read Connection Info by bd address",
+			read_connection_info_cmd, 7, true,
+			read_connection_info_rsp, 1, false },
 	{ 0x02f, "Write BD Data",
 			write_bd_data_cmd, 6, false },
 	{ 0x030, "Read BD Data",
-- 
2.34.1

