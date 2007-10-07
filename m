Return-Path: <fabchevalier@free.fr>
Message-ID: <47092B7D.5000404@free.fr>
Date: Sun, 07 Oct 2007 20:54:53 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Brad Midgley <bmidgley@xmission.com>,
        Johan Hedberg <johan.hedberg@nokia.com>, luiz.dentz@gmail.com,
        Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [PATCH] Alsa plugin fix
Content-Type: multipart/mixed;
 boundary="------------060906060906090100030601"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060906060906090100030601
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

All,

I've spent most of my afternoon fixing the support for my favorite media 
player, the descendant of XMMS : audacious. :-)

Audacious was almost working except for a *very* annoying bug (in our 
side :-( ). It would
eventually stop playing at the end of each song, which meant i would 
have to manually select the next song and hit play again... not very 
funny :-(

Now it looks it works perfectly (didn't have time to check that in 
details, but that should be fixed as soon i tomorrow, after i would
have spent the most part of the day listening to music with Audacious ;-) )

The patch is fairly simple, it implements the delay() call to make sure 
we change the pcm state to the XRUN state whenever the hw_ptr moves
on top of appl_ptr.

Anybody to review it and commit to CVS ?

Cheers,

Fabien

--------------060906060906090100030601
Content-Type: text/plain;
 name="plugin-xun-fix.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="plugin-xun-fix.diff"

SW5kZXg6IHBjbV9ibHVldG9vdGguYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBwY21fYmx1ZXRvb3Ro
LmMJKHLDqXZpc2lvbiA3NCkKKysrIHBjbV9ibHVldG9vdGguYwkoY29waWUgZGUgdHJhdmFp
bCkKQEAgLTc2NCw2ICs3NjQsMjUgQEAKIAlyZXR1cm4gcmV0OwogfQogCitzdGF0aWMgaW50
IGJsdWV0b290aF9wbGF5YmFja19kZWxheShzbmRfcGNtX2lvcGx1Z190ICppbywgCisJCQkJ
c25kX3BjbV9zZnJhbWVzX3QgKmRlbGF5cCkKK3sKKwlEQkcoIiIpOworCisJLyogVGhpcyB1
cGRhdGVzIGlvLT5od19wdHIgdmFsdWUgdXNpbmcgcG9pbnRlcigpIGZ1bmN0aW9uICovCisJ
c25kX3BjbV9od3N5bmMoaW8tPnBjbSk7CisgCQorCSpkZWxheXAgPSBpby0+YXBwbF9wdHIg
LSBpby0+aHdfcHRyOworCWlmICgoaW8tPnN0YXRlID09IFNORF9QQ01fU1RBVEVfUlVOTklO
RykgJiYgKCpkZWxheXAgPCAwKSkgeworCQlpby0+Y2FsbGJhY2stPnN0b3AoaW8pOworCQlp
by0+c3RhdGUgPSBTTkRfUENNX1NUQVRFX1hSVU47CisJCSpkZWxheXAgPSAwOworCX0KKwkv
KiBUaGlzIHNob3VsZCBuZXZlciBmYWlsLCBBTFNBIEFQSSBpcyByZWFsbHkgbm90CisJcHJl
cGFyZWQgdG8gaGFuZGxlIGEgbm9uIHplcm8gcmV0dXJuIHZhbHVlICovCisJcmV0dXJuIDA7
Cit9CisKIHN0YXRpYyBzbmRfcGNtX2lvcGx1Z19jYWxsYmFja190IGJsdWV0b290aF9oc3Bf
cGxheWJhY2sgPSB7CiAJLnN0YXJ0CQkJPSBibHVldG9vdGhfcGxheWJhY2tfc3RhcnQsCiAJ
LnN0b3AJCQk9IGJsdWV0b290aF9wbGF5YmFja19zdG9wLApAQCAtNzc0LDYgKzc5Myw3IEBA
CiAJLnRyYW5zZmVyCQk9IGJsdWV0b290aF9oc3Bfd3JpdGUsCiAJLnBvbGxfZGVzY3JpcHRv
cnMJPSBibHVldG9vdGhfcGxheWJhY2tfcG9sbF9kZXNjcmlwdG9ycywKIAkucG9sbF9yZXZl
bnRzCQk9IGJsdWV0b290aF9wbGF5YmFja19wb2xsX3JldmVudHMsCisJLmRlbGF5CQkJPSBi
bHVldG9vdGhfcGxheWJhY2tfZGVsYXksCiB9OwogCiBzdGF0aWMgc25kX3BjbV9pb3BsdWdf
Y2FsbGJhY2tfdCBibHVldG9vdGhfaHNwX2NhcHR1cmUgPSB7CkBAIC03OTgsNiArODE4LDcg
QEAKIAkudHJhbnNmZXIJCT0gYmx1ZXRvb3RoX2EyZHBfd3JpdGUsCiAJLnBvbGxfZGVzY3Jp
cHRvcnMJPSBibHVldG9vdGhfcGxheWJhY2tfcG9sbF9kZXNjcmlwdG9ycywKIAkucG9sbF9y
ZXZlbnRzCQk9IGJsdWV0b290aF9wbGF5YmFja19wb2xsX3JldmVudHMsCisJLmRlbGF5CQkJ
PSBibHVldG9vdGhfcGxheWJhY2tfZGVsYXksCiB9OwogCiBzdGF0aWMgc25kX3BjbV9pb3Bs
dWdfY2FsbGJhY2tfdCBibHVldG9vdGhfYTJkcF9jYXB0dXJlID0gewo=
--------------060906060906090100030601--
