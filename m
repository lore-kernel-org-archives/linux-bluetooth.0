Return-Path: <cyrus@holtmann.org>
Message-ID: <3837d8b10807231531h36402a71g3ee5ac500a5dc45@mail.gmail.com>
Date: Wed, 23 Jul 2008 17:31:30 -0500
From: "keith preston" <keithpre@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluez a2dp alsa fix
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_95411_978661.1216852290295"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

------=_Part_95411_978661.1216852290295
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There is a small bug in pcm_bluetooth.c.   Typically in an alsa write
call you return the number of samples(frames) that you have processed.
  However in this case where we don't have a full block to encode in
SBC, we return basically return (incoming_buffer_size) %
(SBC_Encode_Block_size).   This is correct in the case where
(incoming_buffer_size) < (SBC_Encode_Block_size), however is wrong
when (incoming_buffer_size) > (SBC_Encode_Block_size), because this
statement ignores previously processed blocks.  This is a small one
line fix.   Patch is attached.    Also I don't know if anyone is
actively working on this, but this section of code is rather
inefficent.   The memcopy is only needed when partial blocks are found
and there are way too many repeated calculations inside the for loop.
 I guess a patch for that will come another day though.

Keith Preston

------=_Part_95411_978661.1216852290295
Content-Type: text/x-patch; name=return-correct-number-of-frames.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fj0iawez0
Content-Disposition: attachment;
 filename=return-correct-number-of-frames.patch

ZGlmZiAtTmF1ciBibHVlei11dGlscy0zLjM2Lm9yaWcvYXVkaW8vcGNtX2JsdWV0b290aC5jIGJs
dWV6LXV0aWxzLTMuMzYvYXVkaW8vcGNtX2JsdWV0b290aC5jCi0tLSBibHVlei11dGlscy0zLjM2
Lm9yaWcvYXVkaW8vcGNtX2JsdWV0b290aC5jCTIwMDgtMDctMjMgMTc6MTM6MTMuMDAwMDAwMDAw
IC0wNTAwCisrKyBibHVlei11dGlscy0zLjM2L2F1ZGlvL3BjbV9ibHVldG9vdGguYwkyMDA4LTA3
LTIzIDE3OjEzOjU2LjAwMDAwMDAwMCAtMDUwMApAQCAtMTAzMiw3ICsxMDMyLDcgQEAKIAkJLyog
UmVtZW1iZXIgd2UgaGF2ZSBzb21lIGZyYW1lcyBpbiB0aGUgcGlwZSBub3cgKi8KIAkJZGF0YS0+
Y291bnQgKz0gZnJhbWVzX3RvX3JlYWQgKiBmcmFtZV9zaXplOwogCQlpZiAoZGF0YS0+Y291bnQg
IT0gYTJkcC0+Y29kZXNpemUpIHsKLQkJCXJldCA9IGZyYW1lc190b19yZWFkOworCQkJcmV0ICs9
IGZyYW1lc190b19yZWFkOwogCQkJZ290byBkb25lOwogCQl9CiAK
------=_Part_95411_978661.1216852290295--
