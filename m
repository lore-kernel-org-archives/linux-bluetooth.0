Return-Path: <cyrus@holtmann.org>
Message-ID: <8a8adccc0712161405l301ad3b4p771bea92d835d070@mail.gmail.com>
Date: Sun, 16 Dec 2007 23:05:44 +0100
From: "Jaap A. Haitsma" <jaap@haitsma.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1197841994.8050.45.camel@aeonflux>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_10653_7237952.1197842744454"
References: <8a8adccc0712161331u26260504gfa88aa9f0218dc7@mail.gmail.com>
	<1197841994.8050.45.camel@aeonflux>
Subject: Re: [Bluez-devel] [PATCH] Use PO Linguas for i18n
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

------=_Part_10653_7237952.1197842744454
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 16, 2007 10:53 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jaap,
>
>
> > See GNOME Goal
> > http://live.gnome.org/GnomeGoals/PoLinguas
> >
> > * Attached patch has to be applied
> > * Attached LINGUAS file has to be put in the po directory
> > * po/Makefile.in.in can be removed
>
> send a proper patch and don't move around parts of the configure.in
> without any real reason. I wanna see the real changes that are needed
> and not see the differences between autoconf styles.

Sorry. Here's the patch again

Jaap

------=_Part_10653_7237952.1197842744454
Content-Type: text/x-patch; name=gnome-bluetoot-polinguas.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_faa4l1v30
Content-Disposition: attachment; filename=gnome-bluetoot-polinguas.patch

PyBNYWtlZmlsZS5pbgo/IGFjbG9jYWwubTQKPyBhdXRvZ2VuLnNoCj8gYXV0b200dGUuY2FjaGUK
PyBjb25maWcuZ3Vlc3MKPyBjb25maWcuaC5pbgo/IGNvbmZpZy5zdWIKPyBjb25maWd1cmUKPyBj
b25maWd1cmUuaW4ubmV3Cj8gZGVwY29tcAo/IGluc3RhbGwtc2gKPyBpbnRsdG9vbC1leHRyYWN0
LmluCj8gaW50bHRvb2wtbWVyZ2UuaW4KPyBpbnRsdG9vbC11cGRhdGUuaW4KPyBtaXNzaW5nCj8g
bWtpbnN0YWxsZGlycwo/IG9tZi5tYWtlCj8geG1sZG9jcy5tYWtlCj8gYW5hbHl6ZXIvTWFrZWZp
bGUuaW4KPyBhcHBsZXQvTWFrZWZpbGUuaW4KPyBjb21tb24vTWFrZWZpbGUuaW4KPyBwby9MSU5H
VUFTCj8gcG8vTWFrZWZpbGUuaW4uaW4KPyBwcm9wZXJ0aWVzL01ha2VmaWxlLmluCj8gcHJveGlt
aXR5L01ha2VmaWxlLmluCj8gc2VuZHRvL01ha2VmaWxlLmluCj8gd2l6YXJkL01ha2VmaWxlLmlu
CkluZGV4OiBjb25maWd1cmUuaW4KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvYmx1ZXov
Z25vbWUvY29uZmlndXJlLmluLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjU1CmRpZmYgLXUgLXIx
LjU1IGNvbmZpZ3VyZS5pbgotLS0gY29uZmlndXJlLmluCTI5IEF1ZyAyMDA3IDEzOjE5OjUwIC0w
MDAwCTEuNTUKKysrIGNvbmZpZ3VyZS5pbgkxNiBEZWMgMjAwNyAyMjowMzowNiAtMDAwMApAQCAt
MTUsMTQgKzE1LDE3IEBACiBBQ19QUk9HX0lOU1RBTEwKIEFDX1BST0dfUkFOTElCCiAKKyMqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqCisjIEludGVybmF0aW9uYWxpemF0aW9uCisjKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKgogR0VUVEVYVF9QQUNLQUdFPWJsdWV0b290aC1tYW5hZ2VyCiBBQ19TVUJTVChH
RVRURVhUX1BBQ0tBR0UpCi1BQ19ERUZJTkVfVU5RVU9URUQoR0VUVEVYVF9QQUNLQUdFLCAiJEdF
VFRFWFRfUEFDS0FHRSIsIFtUaGUgbmFtZSBvZiB0aGUgZ2V0dGV4dCBkb21haW5dKQorQUNfREVG
SU5FX1VOUVVPVEVEKEdFVFRFWFRfUEFDS0FHRSwiJEdFVFRFWFRfUEFDS0FHRSIsIFtHRVRURVhU
IHBhY2thZ2UgbmFtZV0pCiAKLUFMTF9MSU5HVUFTPSJmaSBwdF9CUiBwbCBodSBybyB0ciBjYSB6
aF9DTiBzciBpZCBydSBzayBuYiBpdCBzdiBiZyBlbl9HQiBmciBjcyBubCBrdSBlcyBwdCBkZSBk
YSIKK0lUX1BST0dfSU5UTFRPT0woWzAuMzUuMF0pCiBBTV9HTElCX0dOVV9HRVRURVhUCiAKLUlU
X1BST0dfSU5UTFRPT0wKKyMqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAKIEFDX1BBVEhfUFJPRyhH
Q09ORlRPT0wsIFtnY29uZnRvb2wtMl0pCiBBTV9HQ09ORl9TT1VSQ0VfMgo=
------=_Part_10653_7237952.1197842744454
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
------=_Part_10653_7237952.1197842744454
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_Part_10653_7237952.1197842744454--
