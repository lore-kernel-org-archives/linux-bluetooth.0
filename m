Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-26RD9c/8Ggg0VM4jEm40"
Message-Id: <1141132514.18703.6.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] l2cap.c: adding some kernel-docs
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 28 Feb 2006 14:15:14 +0100


--=-26RD9c/8Ggg0VM4jEm40
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This small patch adds kernel-docs for four functions in l2cap.c.
Kernel-docs can be used to annotate functions and their parameters like
the following:

/**
 * l2cap_parse_conf_req - parses a conf req packet for options
 * @sk: corresponding socket
 * @data: contains type, length and option data
 * @len: length of the whole configuration request packet
 *
 * Parses a configuration request that may contain multiple
configuration
 * options. Sets the appropriate configuration request parameters from
the
 * remote peer if understood.
 */

One can obtain the information on those annotations in multiple ways,
for example by using the man page style:
  scripts/kernel-doc -man net/bluetooth/l2cap.c | nroff -man | less

I think it's worth the effort for some functions to keep track of the
functionality and the use of different parameters.

Martin

--=-26RD9c/8Ggg0VM4jEm40
Content-Disposition: attachment; filename=patch-kernel-doc
Content-Type: text/plain; name=patch-kernel-doc; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.6.15-mh2/net/bluetooth/l2cap.c	2006-02-16 11:38:19.000000000 +0100
+++ linux-2.6.15-mr/net/bluetooth/l2cap.c	2006-02-28 14:14:27.000000000 +0100
@@ -1267,6 +1267,16 @@
 	return len;
 }
 
+/**
+ * l2cap_parse_conf_req - parses a conf req packet for options
+ * @sk: corresponding socket
+ * @data: contains type, length and option data
+ * @len: length of the whole configuration request packet
+ *
+ * Parses a configuration request that may contain multiple configuration 
+ * options. Sets the appropriate configuration request parameters from the 
+ * remote peer if understood.
+ */
 static inline void l2cap_parse_conf_req(struct sock *sk, void *data, u16 len)
 {
 	int type, hint, olen; 
@@ -1303,6 +1313,16 @@
 	}
 }
 
+/**
+ * l2cap_add_conf_opt - adds a conf option to a response or a request
+ * @ptr: pointer to complete option
+ * @type: option type (e.g. L2CAP_CONF_MTU)
+ * @len: length of option in Bytes (e.g. MTU == 2, RFC == 9)
+ * @val: contains the data that is being added
+ *
+ * Adds a complete configuration parameter option to a configuration response
+ * or a configuration request.
+ */
 static void l2cap_add_conf_opt(void **ptr, u8 type, u8 len, unsigned long val)
 {
 	struct l2cap_conf_opt *opt = *ptr;
@@ -1333,6 +1353,14 @@
 	*ptr += L2CAP_CONF_OPT_SIZE + len;
 }
 
+/**
+ * l2cap_build_conf_req - Builds a configuration request
+ * @sk: corresponding socket structure
+ * @data: data portion of a conf request packet (dcid, flags, options)
+ * @return: packet length (dcid, flags and options)
+ *
+ * Builds a configuration request with the help of l2cap_add_conf_opt
+ */
 static int l2cap_build_conf_req(struct sock *sk, void *data)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -1372,6 +1400,13 @@
 	return result;
 }
 
+/**
+ * l2cap_build_conf_rsp - Builds a configuration response
+ * @sk: corresponding socket structure
+ * @data: data portion of rsp packet (scid, flags, result, config)
+ * @result: result code for response (success/reject/failure/...)
+ * @return: command length
+ */
 static int l2cap_build_conf_rsp(struct sock *sk, void *data, int *result)
 {
 	struct l2cap_conf_rsp *rsp = data;

--=-26RD9c/8Ggg0VM4jEm40--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
