Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 2/6] Remove extra spaces at end of line in lib dir
Date: Fri,  7 May 2010 00:27:08 +0200
Message-Id: <1273184832-8265-2-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1273184832-8265-1-git-send-email-santoscadenas@gmail.com>
References: <1273184832-8265-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.c |    2 +-
 lib/hci.c       |   10 ++--
 lib/hci.h       |    6 +-
 lib/sdp.h       |    2 +-
 lib/sdp_lib.h   |  130 +++++++++++++++++++++++++++---------------------------
 5 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index e8f8341..9e4b242 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -55,7 +55,7 @@ char *batostr(const bdaddr_t *ba)
 		return NULL;
 
 	sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
-		ba->b[0], ba->b[1], ba->b[2], 
+		ba->b[0], ba->b[1], ba->b[2],
 		ba->b[3], ba->b[4], ba->b[5]);
 
 	return str;
diff --git a/lib/hci.c b/lib/hci.c
index 858b9f1..114d066 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -54,7 +54,7 @@ typedef struct {
 	unsigned int val;
 } hci_map;
 
-static char *hci_bit2str(hci_map *m, unsigned int val) 
+static char *hci_bit2str(hci_map *m, unsigned int val)
 {
 	char *str = malloc(120);
 	char *ptr = str;
@@ -95,7 +95,7 @@ static int hci_str2bit(hci_map *map, char *str, unsigned int *val)
 	return set;
 }
 
-static char *hci_uint2str(hci_map *m, unsigned int val) 
+static char *hci_uint2str(hci_map *m, unsigned int val)
 {
 	char *str = malloc(50);
 	char *ptr = str;
@@ -209,7 +209,7 @@ char *hci_dflagstostr(uint32_t flags)
 		if (hci_test_bit(m->val, &flags))
 			ptr += sprintf(ptr, "%s ", m->str);
 		m++;
-	} 	
+	}
 	return str;
 }
 
@@ -959,7 +959,7 @@ int hci_inquiry(int dev_id, int len, int nrsp, const uint8_t *lap, inquiry_info
 			errno = ENODEV;
 			return -1;
 		}
-	}	
+	}
 
 	dd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
 	if (dd < 0)
@@ -1009,7 +1009,7 @@ done:
 	return ret;
 }
 
-/* Open HCI device. 
+/* Open HCI device.
  * Returns device descriptor (dd). */
 int hci_open_dev(int dev_id)
 {
diff --git a/lib/hci.h b/lib/hci.h
index 883f5dc..996dab3 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -733,14 +733,14 @@ typedef struct {
 typedef struct {
 	uint8_t		name[248];
 } __attribute__ ((packed)) change_local_name_cp;
-#define CHANGE_LOCAL_NAME_CP_SIZE 248 
+#define CHANGE_LOCAL_NAME_CP_SIZE 248
 
 #define OCF_READ_LOCAL_NAME		0x0014
 typedef struct {
 	uint8_t		status;
 	uint8_t		name[248];
 } __attribute__ ((packed)) read_local_name_rp;
-#define READ_LOCAL_NAME_RP_SIZE 249 
+#define READ_LOCAL_NAME_RP_SIZE 249
 
 #define OCF_READ_CONN_ACCEPT_TIMEOUT	0x0015
 typedef struct {
@@ -828,7 +828,7 @@ typedef struct {
 	uint8_t		status;
 	uint8_t		dev_class[3];
 } __attribute__ ((packed)) read_class_of_dev_rp;
-#define READ_CLASS_OF_DEV_RP_SIZE 4 
+#define READ_CLASS_OF_DEV_RP_SIZE 4
 
 #define OCF_WRITE_CLASS_OF_DEV		0x0024
 typedef struct {
diff --git a/lib/sdp.h b/lib/sdp.h
index 5b2901f..a33e0a8 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -297,7 +297,7 @@ extern "C" {
 #define SDP_ATTR_HID_BOOT_DEVICE		0x020e
 
 /*
- * These identifiers are based on the SDP spec stating that 
+ * These identifiers are based on the SDP spec stating that
  * "base attribute id of the primary (universal) language must be 0x0100"
  *
  * Other languages should have their own offset; e.g.:
diff --git a/lib/sdp_lib.h b/lib/sdp_lib.h
index cef3131..e506ac1 100644
--- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -47,7 +47,7 @@ sdp_list_t *sdp_list_remove(sdp_list_t *list, void *d);
 sdp_list_t *sdp_list_insert_sorted(sdp_list_t *list, void *data, sdp_comp_func_t f);
 void        sdp_list_free(sdp_list_t *list, sdp_free_func_t f);
 
-static inline int sdp_list_len(const sdp_list_t *list) 
+static inline int sdp_list_len(const sdp_list_t *list)
 {
 	int n = 0;
 	for (; list; list = list->next)
@@ -118,9 +118,9 @@ typedef void sdp_callback_t(uint8_t type, uint16_t status, uint8_t *rsp, size_t
 
 /*
  * create an L2CAP connection to a Bluetooth device
- * 
+ *
  * INPUT:
- *  
+ *
  *  bdaddr_t *src:
  *	Address of the local device to use to make the connection
  *	(or BDADDR_ANY)
@@ -174,29 +174,29 @@ int sdp_set_uuidseq_attr(sdp_record_t *rec, uint16_t attr, sdp_list_t *seq);
 int sdp_get_uuidseq_attr(const sdp_record_t *rec, uint16_t attr, sdp_list_t **seqp);
 
 /*
- * NOTE that none of the functions below will update the SDP server, 
+ * NOTE that none of the functions below will update the SDP server,
  * unless the {register, update}sdp_record_t() function is invoked.
- * All functions which return an integer value, return 0 on success 
+ * All functions which return an integer value, return 0 on success
  * or -1 on failure.
  */
 
 /*
  * Create an attribute and add it to the service record's attribute list.
- * This consists of the data type descriptor of the attribute, 
+ * This consists of the data type descriptor of the attribute,
  * the value of the attribute and the attribute identifier.
  */
 int sdp_attr_add_new(sdp_record_t *rec, uint16_t attr, uint8_t dtd, const void *p);
 
 /*
  * Set the information attributes of the service record.
- * The set of attributes comprises service name, description 
+ * The set of attributes comprises service name, description
  * and provider name
  */
 void sdp_set_info_attr(sdp_record_t *rec, const char *name, const char *prov, const char *desc);
 
 /*
  * Set the ServiceClassID attribute to the sequence specified by seq.
- * Note that the identifiers need to be in sorted order from the most 
+ * Note that the identifiers need to be in sorted order from the most
  * specific to the most generic service class that this service
  * conforms to.
  */
@@ -207,8 +207,8 @@ static inline int sdp_set_service_classes(sdp_record_t *rec, sdp_list_t *seq)
 
 /*
  * Get the service classes to which the service conforms.
- * 
- * When set, the list contains elements of ServiceClassIdentifer(uint16_t) 
+ *
+ * When set, the list contains elements of ServiceClassIdentifer(uint16_t)
  * ordered from most specific to most generic
  */
 static inline int sdp_get_service_classes(const sdp_record_t *rec, sdp_list_t **seqp)
@@ -218,8 +218,8 @@ static inline int sdp_get_service_classes(const sdp_record_t *rec, sdp_list_t **
 
 /*
  * Set the BrowseGroupList attribute to the list specified by seq.
- * 
- * A service can belong to one or more service groups 
+ *
+ * A service can belong to one or more service groups
  * and the list comprises such group identifiers (UUIDs)
  */
 static inline int sdp_set_browse_groups(sdp_record_t *rec, sdp_list_t *seq)
@@ -238,24 +238,24 @@ int sdp_set_access_protos(sdp_record_t *rec, const sdp_list_t *proto);
 int sdp_set_add_access_protos(sdp_record_t *rec, const sdp_list_t *proto);
 
 /*
- * Get protocol port (i.e. PSM for L2CAP, Channel for RFCOMM) 
+ * Get protocol port (i.e. PSM for L2CAP, Channel for RFCOMM)
  */
 int sdp_get_proto_port(const sdp_list_t *list, int proto);
 
 /*
- * Get protocol descriptor. 
+ * Get protocol descriptor.
  */
 sdp_data_t *sdp_get_proto_desc(sdp_list_t *list, int proto);
 
 /*
- * Set the LanguageBase attributes to the values specified in list 
- * (a linked list of sdp_lang_attr_t objects, one for each language in 
+ * Set the LanguageBase attributes to the values specified in list
+ * (a linked list of sdp_lang_attr_t objects, one for each language in
  * which user-visible attributes are present).
  */
 int sdp_set_lang_attr(sdp_record_t *rec, const sdp_list_t *list);
 
 /*
- * Set the ServiceInfoTimeToLive attribute of the service.  
+ * Set the ServiceInfoTimeToLive attribute of the service.
  * This is the number of seconds that this record is guaranteed
  * not to change after being obtained by a client.
  */
@@ -266,8 +266,8 @@ static inline int sdp_set_service_ttl(sdp_record_t *rec, uint32_t ttl)
 
 /*
  * Set the ServiceRecordState attribute of a service. This is
- * guaranteed to change if there is any kind of modification to 
- * the record. 
+ * guaranteed to change if there is any kind of modification to
+ * the record.
  */
 static inline int sdp_set_record_state(sdp_record_t *rec, uint32_t state)
 {
@@ -275,7 +275,7 @@ static inline int sdp_set_record_state(sdp_record_t *rec, uint32_t state)
 }
 
 /*
- * Set the ServiceID attribute of a service. 
+ * Set the ServiceID attribute of a service.
  */
 void sdp_set_service_id(sdp_record_t *rec, uuid_t uuid);
 
@@ -286,7 +286,7 @@ void sdp_set_group_id(sdp_record_t *rec, uuid_t grouuuid);
 
 /*
  * Set the ServiceAvailability attribute of a service.
- * 
+ *
  * Note that this represents the relative availability
  * of the service: 0x00 means completely unavailable;
  * 0xFF means maximum availability.
@@ -298,7 +298,7 @@ static inline int sdp_set_service_avail(sdp_record_t *rec, uint8_t avail)
 
 /*
  * Set the profile descriptor list attribute of a record.
- * 
+ *
  * Each element in the list is an object of type
  * sdp_profile_desc_t which is a definition of the
  * Bluetooth profile that this service conforms to.
@@ -307,41 +307,41 @@ int sdp_set_profile_descs(sdp_record_t *rec, const sdp_list_t *desc);
 
 /*
  * Set URL attributes of a record.
- * 
- * ClientExecutableURL: a URL to a client's platform specific (WinCE, 
+ *
+ * ClientExecutableURL: a URL to a client's platform specific (WinCE,
  * PalmOS) executable code that can be used to access this service.
- * 
+ *
  * DocumentationURL: a URL pointing to service documentation
- * 
+ *
  * IconURL: a URL to an icon that can be used to represent this service.
- * 
+ *
  * Note: pass NULL for any URLs that you don't want to set or remove
  */
 void sdp_set_url_attr(sdp_record_t *rec, const char *clientExecURL, const char *docURL, const char *iconURL);
 
 /*
- * a service search request. 
- * 
+ * a service search request.
+ *
  *  INPUT :
- * 
+ *
  *    sdp_list_t *search
  *      list containing elements of the search
  *      pattern. Each entry in the list is a UUID
  *      of the service to be searched
- * 
+ *
  *    uint16_t max_rec_num
  *       An integer specifying the maximum number of
  *       entries that the client can handle in the response.
- * 
+ *
  *  OUTPUT :
- * 
+ *
  *    int return value
- *      0 
+ *      0
  *        The request completed successfully. This does not
  *        mean the requested services were found
  *      -1
  *        The request completed unsuccessfully
- * 
+ *
  *    sdp_list_t *rsp_list
  *      This variable is set on a successful return if there are
  *      non-zero service handles. It is a singly linked list of
@@ -350,33 +350,33 @@ void sdp_set_url_attr(sdp_record_t *rec, const char *clientExecURL, const char *
 int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search, uint16_t max_rec_num, sdp_list_t **rsp_list);
 
 /*
- *  a service attribute request. 
- * 
+ *  a service attribute request.
+ *
  *  INPUT :
- * 
+ *
  *    uint32_t handle
  *      The handle of the service for which the attribute(s) are
  *      requested
- * 
+ *
  *    sdp_attrreq_type_t reqtype
  *      Attribute identifiers are 16 bit unsigned integers specified
  *      in one of 2 ways described below :
  *      SDP_ATTR_REQ_INDIVIDUAL - 16bit individual identifiers
  *         They are the actual attribute identifiers in ascending order
- * 
+ *
  *      SDP_ATTR_REQ_RANGE - 32bit identifier range
  *         The high-order 16bits is the start of range
  *         the low-order 16bits are the end of range
  *         0x0000 to 0xFFFF gets all attributes
- * 
+ *
  *    sdp_list_t *attrid_list
  *      Singly linked list containing attribute identifiers desired.
- *      Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)  
+ *      Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)
  *      or a uint32_t(attrSpec=SDP_ATTR_REQ_RANGE)
- * 
+ *
  *  OUTPUT :
  *    int return value
- *      0 
+ *      0
  *        The request completed successfully. This does not
  *        mean the requested services were found
  *      -1
@@ -388,38 +388,38 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle, sdp_
  *  This is a service search request combined with the service
  *  attribute request. First a service class match is done and
  *  for matching service, requested attributes are extracted
- * 
+ *
  *  INPUT :
- * 
+ *
  *    sdp_list_t *search
  *      Singly linked list containing elements of the search
  *      pattern. Each entry in the list is a UUID(DataTypeSDP_UUID16)
  *      of the service to be searched
- * 
+ *
  *    AttributeSpecification attrSpec
  *      Attribute identifiers are 16 bit unsigned integers specified
  *      in one of 2 ways described below :
  *      SDP_ATTR_REQ_INDIVIDUAL - 16bit individual identifiers
  *         They are the actual attribute identifiers in ascending order
- * 
+ *
  *      SDP_ATTR_REQ_RANGE - 32bit identifier range
  *         The high-order 16bits is the start of range
  *         the low-order 16bits are the end of range
  *         0x0000 to 0xFFFF gets all attributes
- * 
+ *
  *    sdp_list_t *attrid_list
  *      Singly linked list containing attribute identifiers desired.
- *      Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)  
+ *      Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)
  *      or a uint32_t(attrSpec=SDP_ATTR_REQ_RANGE)
- * 
+ *
  *  OUTPUT :
  *    int return value
- *      0 
+ *      0
  *        The request completed successfully. This does not
  *        mean the requested services were found
  *      -1
  *        The request completed unsuccessfully due to a timeout
- * 
+ *
  *    sdp_list_t *rsp_list
  *      This variable is set on a successful return to point to
  *      service(s) found. Each element of this list is of type
@@ -434,12 +434,12 @@ sdp_record_t *sdp_record_alloc(void);
 void sdp_record_free(sdp_record_t *rec);
 
 /*
- * Register a service record. 
- * 
- * Note: It is the responsbility of the Service Provider to create the 
+ * Register a service record.
+ *
+ * Note: It is the responsbility of the Service Provider to create the
  * record first and set its attributes using setXXX() methods.
- * 
- * The service provider must then call sdp_record_register() to make 
+ *
+ * The service provider must then call sdp_record_register() to make
  * the service record visible to SDP clients.  This function returns 0
  * on success or -1 on failure (and sets errno).
  */
@@ -493,14 +493,14 @@ int sdp_svclass_uuid2strn(const uuid_t *uuid, char *str, size_t n);
 int sdp_profile_uuid2strn(const uuid_t *uuid, char *str, size_t n);
 
 /*
- * In all the sdp_get_XXX(handle, XXX *xxx) functions below, 
+ * In all the sdp_get_XXX(handle, XXX *xxx) functions below,
  * the XXX * is set to point to the value, should it exist
  * and 0 is returned. If the value does not exist, -1 is
  * returned and errno set to ENODATA.
  *
  * In all the methods below, the memory management rules are
  * simple. Don't free anything! The pointer returned, in the
- * case of constructed types, is a pointer to the contents 
+ * case of constructed types, is a pointer to the contents
  * of the sdp_record_t.
  */
 
@@ -516,7 +516,7 @@ int sdp_get_add_access_protos(const sdp_record_t *rec, sdp_list_t **protos);
 
 /*
  * Extract the list of browse groups to which the service belongs.
- * When set, seqp contains elements of GroupID (uint16_t) 
+ * When set, seqp contains elements of GroupID (uint16_t)
  */
 static inline int sdp_get_browse_groups(const sdp_record_t *rec, sdp_list_t **seqp)
 {
@@ -524,9 +524,9 @@ static inline int sdp_get_browse_groups(const sdp_record_t *rec, sdp_list_t **se
 }
 
 /*
- * Extract language attribute meta-data of the service record. 
+ * Extract language attribute meta-data of the service record.
  * For each language in the service record, LangSeq has a struct of type
- * sdp_lang_attr_t. 
+ * sdp_lang_attr_t.
  */
 int sdp_get_lang_attr(const sdp_record_t *rec, sdp_list_t **langSeq);
 
@@ -540,8 +540,8 @@ int sdp_get_lang_attr(const sdp_record_t *rec, sdp_list_t **langSeq);
 int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDesc);
 
 /*
- * Extract SDP server version numbers 
- * 
+ * Extract SDP server version numbers
+ *
  * Note: that this is an attribute of the SDP server only and
  * contains a list of uint16_t each of which represent the
  * major and minor SDP version numbers supported by this server
-- 
1.7.0.4

