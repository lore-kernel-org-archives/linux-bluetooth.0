Return-Path: <SRS0=2sDM=QZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB8BC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Feb 2019 22:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843DD21479
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Feb 2019 22:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfBRWKi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:10:38 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:36895 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731506AbfBRWKi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Feb 2019 17:10:38 -0500
Received: from oxbaltgw06.schlund.de ([172.19.246.12]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MysiI-1hHWw61PYw-00w01L; Mon, 18 Feb 2019 23:10:16 +0100
Date:   Mon, 18 Feb 2019 23:10:12 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        beagleboard@davidjohnsummers.uk, linux-bluetooth@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Message-ID: <1591759260.588063.1550527812700@email.ionos.de>
In-Reply-To: <1245842044.588056.1550527701604@email.ionos.de>
References: <20190118170232.16142-1-anarsoul@gmail.com>
 <20190118170232.16142-4-anarsoul@gmail.com> <20190218211035.GA28145@bogus>
 <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
 <1245842044.588056.1550527701604@email.ionos.de>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add
 rtl8723bs-bluetooth
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:jETn6HhGS0cIqrr4t3UqX3KcZyWyaXnBtD/hiP91znatfoeYtVD
 aFCABcy+W7ujbWpwPZX0U9Owsr3xLik7+hRiSWc6vkzQXsM+P3ZHsxZk/sKhM5EHka/er7Y
 sQjIvGJy+MiwZ6EsTy04s0i1ZbxyKW1QcIjmQh0bF+RkShIxjhJWflAQ+ygHmSgGkbSTFco
 523gsnyX8E7gikck5vyQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fb/pd/YD/lM=:XZTH8fYFp8HGLdhAbMvV3y
 S2EDsndEfqDAtVu1Hpgl49LbNwKWWm3QE+VWlO4Z584UR1Rfst/TiZTUHeMdWxazKEE1I+xBx
 M6XvVksa1SsCWJT2PBfUxuv7TrZ8sck1LuCU5vx7IuRP9BlU62CsXtLBvT8sFCxnljAY+84Rt
 tTQANiQ010wFE6B49DGMWPSgeOIo1mdwl4LKmpsTKHFEoRMGXQfUuhZ34lsd5eexbBN2nbsNr
 0hBL/IYRwx7V2bSwTYhJaFxW4V1T1It+ulSOaKz8uvqNvhLFzpBdQ0/rD1Hfixna3FFe9qUj9
 DP4P7jIl+jNjNWLM2l7sJqwDNDesYGztM/YKh1QBWLtNG+WI9/GK3cl8WB1VWqls1EPj7tJEH
 iUNoYNIp4HseMeLJ0aPxLEJIorYLqwmzsKVNB4RS9vKj5OMoqraDkKnGg3ArOiXSmcRU+y7Iy
 KeGVj5ktyWJpcqnx5Tk4gZplbOZCCloast7CAH7AIEVkbVUwxoAa6zkLtgfrf+DjRSv2DIuE4
 ks543x3HO32wBxTkIQSS+AJneYIUBrzkkkQhTYxQoI7dHDCD14B8N9SoTzLhWzxb7qymvelLR
 TcrWwJvSY6zuLNIVUDpy2wJRPhB3IOlgLMDLVzLYxvKLgPgvofpVjRgCv0hIiGrYqgDnRU4T8
 dnxvZYjsiJmjbhs/znCrF2r9sZ1fnnor7Z2N+Y5akiQhgLjBEAyE2wxfZ1OEvQCspdElbWFyC
 CJmJMSTKoomp6EWPBT3ZY6QIHU5cQyOsIs9CkOO8H41zA6Bw+sbl+QuNlxc=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


> Stefan Wahren <stefan.wahren@i2se.com> hat am 18. Februar 2019 um 23:08 geschrieben:
> 
> 
> Hi Vasily,
> 
> > Vasily Khoruzhick <anarsoul@gmail.com> hat am 18. Februar 2019 um 22:24 geschrieben:
> > 
> > 
> > On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> > > > Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> > > >
> > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > ---
> > > >  .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
> > > >  1 file changed, 35 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > new file mode 100644
> > > > index 000000000000..8357f242ae4c
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > > > @@ -0,0 +1,35 @@
> > > > +RTL8723BS/RTL8723CS Bluetooth
> > > > +---------------------
> > > > +
> > > > +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> > > > +BT is connected over serial. It speaks H5 protocol with few extra commands
> > > > +to upload firmware and change module speed.
> > > > +
> > > > +Required properties:
> > > > +
> > > > + - compatible: should be one of the following:
> > > > +   * "realtek,rtl8723bs-bt"
> > > > +   * "realtek,rtl8723cs-bt"
> > > > +Optional properties:
> > > > +
> > > > + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> > > > + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> > > > + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> > > > + - firmware-postfix: firmware postfix to be used for firmware config
> > >
> 
> sorry, i didn't noticed your great series before. David and i working at the same stuff but for the Asus Tinker Board.
> 
> I created a similiar yet untested patch version for hci_h5 [1]. Maybe it's useful.
> 
> Just a comment about the binding. It's really necessary to add the reset-gpio? Can't we use the enable-gpio with inverse polarity for this?
> 
> Stefan

[1] - https://gist.github.com/lategoodbye/79bac99d4f1158a719a48ea3c45eb7f1
