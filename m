Return-Path: <Andreas.Gaufer@blue-cell-networks.com>
Date: Thu, 10 Jun 2004 22:29:14 +0200
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: andreas.gaufer@blue-cell-networks.com, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Deleted acl-handles on failed hci_create_connection
Message-Id: <20040610222914.5eea2ebb.Andreas.Gaufer@blue-cell-networks.com>
In-Reply-To: <1086893582.7930.55.camel@pegasus>
References: <20040610203555.273c77bd.Andreas.Gaufer@blue-cell-networks.com>
	<1086893582.7930.55.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__10_Jun_2004_22:29:14_+0200_0843f9e8"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.

--Multipart_Thu__10_Jun_2004_22:29:14_+0200_0843f9e8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Marcel,

Your right (like always ;). I assumed that in case af a negative return in 
first try there is no entry created but that was wrong. 

Your change works for me, a patch for 2.4.26 is attached

Greetings & Regards

Andreas Gaufer



On Thu, 10 Jun 2004 20:53:02 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Andreas,
> 
> > Heres a patch for hci_event.c to fix the problem that acl-handles are removed 
> > from the kernels connection hash when a hci_create_connection returnes a
> > command status thats not 0x00.
> > 
> > One of the problems that was caused by this bug was that cc could be issued 
> > even if the peer was already connected. This case leads to the error message 
> > "Too many links" with sdptool and rfcomm for example. This connection could 
> > only be removed if the acl handle was known otherwise or by removing power 
> > from the usb-dongle (unplugg).
> 
> I think your patch is wrong, because in case of the first try through
> L2CAP etc. a negative return value must result in a drop of the hci_conn
> structure. Check if the attached patch is also working (againt 2.6).
> 
> Regards
> 
> Marcel
> 
> 

--Multipart_Thu__10_Jun_2004_22:29:14_+0200_0843f9e8
Content-Type: application/octet-stream;
 name="patch-2.4.26"
Content-Disposition: attachment;
 filename="patch-2.4.26"
Content-Transfer-Encoding: base64

ZGlmZiAtLXVuaWZpZWQgLS1yZWN1cnNpdmUgLUkgL3Jvb3RnYXVmLyAtLW5ldy1maWxlIGxpbnV4
LTIuNC4yNi9uZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jIGxpbnV4LTIuNC4yNi1taC9uZXQvYmx1
ZXRvb3RoL2hjaV9ldmVudC5jCi0tLSBsaW51eC0yLjQuMjYvbmV0L2JsdWV0b290aC9oY2lfZXZl
bnQuYwlXZWQgRmViIDE4IDE0OjM2OjMyIDIwMDQKKysrIGxpbnV4LTIuNC4yNi1taC9uZXQvYmx1
ZXRvb3RoL2hjaV9ldmVudC5jCVRodSBKdW4gMTAgMjI6MTM6MDcgMjAwNApAQCAtMzIwLDcgKzMy
MCw3IEBACiAJCQlzdGF0dXMsIGJhdG9zdHIoJmNjLT5iZGFkZHIpLCBjb25uKTsKIAogCWlmIChz
dGF0dXMpIHsKLQkJaWYgKGNvbm4pIHsKKwkJaWYgKGNvbm4gJiYgY29ubi0+c3RhdGUgPT0gQlRf
Q09OTkVDVCkgewogCQkJY29ubi0+c3RhdGUgPSBCVF9DTE9TRUQ7CiAJCQloY2lfcHJvdG9fY29u
bmVjdF9jZm0oY29ubiwgc3RhdHVzKTsKIAkJCWhjaV9jb25uX2RlbChjb25uKTsK

--Multipart_Thu__10_Jun_2004_22:29:14_+0200_0843f9e8--
