Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sf.net
Message-Id: <20040210124942.393a6da0.collin@betaversion.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__10_Feb_2004_12_49_42_+0100_6qEbKBpVFFekiJoE"
Subject: [Bluez-devel] L2CAP raw socket patch
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 10 Feb 2004 12:49:42 +0100


--Multipart=_Tue__10_Feb_2004_12_49_42_+0100_6qEbKBpVFFekiJoE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi List,

I have written a small patch for l2cap.c to improve the capabilities of
L2CAP raw sockets. Currently only very few responses travel back to a
RAW socket (which is very bad if you need to see command responses).
The patch is very simple - it just puts all responses on the
Sig-Channel to all open RAW sockets. The owner of the raw socket just
needs to select his packets and in normal operation there shouldn't be
much use of RAW sockets so I don't think this is a performance issue.

I have attached the patch file to this email, hope this is ok.


thanks ... Collin

-- 
Collin Mulliner <collin@betaversion.net>
BATAVERSiON Systems [www.betaversion.net]
Don't ask why! Ask why not!


--Multipart=_Tue__10_Feb_2004_12_49_42_+0100_6qEbKBpVFFekiJoE
Content-Type: application/octet-stream;
 name="bluez_l2cap_rawsocket.patch"
Content-Disposition: attachment;
 filename="bluez_l2cap_rawsocket.patch"
Content-Transfer-Encoding: base64

LS0tIG9yaWcvbDJjYXAuYwkyMDAzLTA4LTI1IDEzOjQ0OjQ0LjAwMDAwMDAwMCArMDIwMAorKysg
bDJjYXAuYwkyMDA0LTAyLTA5IDE0OjM1OjEzLjAwMDAwMDAwMCArMDEwMApAQCAtMTY2Myw2ICsx
NjYzLDEyIEBACiAJCQlicmVhazsKIAkJfQogCisJCS8qICAKKwkJICogIGZvciBiZXR0ZXIgbG93
LWxldmVsIGFjY2VzcworCQkgKiAgcHV0IGNvbW1hbmQgdG8gYWxsIHJhdyBzb2NrZXRzCisJCSAq
LworCQlsMmNhcF9yYXdfcmVjdihjb25uLCBza2IpOworCiAJCXN3aXRjaCAoY21kLmNvZGUpIHsK
IAkJY2FzZSBMMkNBUF9DT05OX1JFUToKIAkJCWVyciA9IGwyY2FwX2Nvbm5lY3RfcmVxKGNvbm4s
ICZjbWQsIGRhdGEpOwpAQCAtMTY4OCwyMSArMTY5NCwxMCBAQAogCQkJZXJyID0gbDJjYXBfZGlz
Y29ubmVjdF9yc3AoY29ubiwgJmNtZCwgZGF0YSk7CiAJCQlicmVhazsKIAotCQljYXNlIEwyQ0FQ
X0NPTU1BTkRfUkVKOgotCQkJLyogRklYTUU6IFdlIHNob3VsZCBwcm9jZXNzIHRoaXMgKi8KLQkJ
CWwyY2FwX3Jhd19yZWN2KGNvbm4sIHNrYik7Ci0JCQlicmVhazsKLQogCQljYXNlIEwyQ0FQX0VD
SE9fUkVROgogCQkJbDJjYXBfc2VuZF9yc3AoY29ubiwgY21kLmlkZW50LCBMMkNBUF9FQ0hPX1JT
UCwgY21kLmxlbiwgZGF0YSk7CiAJCQlicmVhazsKIAotCQljYXNlIEwyQ0FQX0VDSE9fUlNQOgot
CQljYXNlIEwyQ0FQX0lORk9fUkVROgotCQljYXNlIEwyQ0FQX0lORk9fUlNQOgotCQkJbDJjYXBf
cmF3X3JlY3YoY29ubiwgc2tiKTsKLQkJCWJyZWFrOwotCiAJCWRlZmF1bHQ6CiAJCQlCVF9FUlIo
IlVrbm93biBzaWduYWxpbmcgY29tbWFuZCAweCUyLjJ4IiwgY21kLmNvZGUpOwogCQkJZXJyID0g
LUVJTlZBTDsK

--Multipart=_Tue__10_Feb_2004_12_49_42_+0100_6qEbKBpVFFekiJoE--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
