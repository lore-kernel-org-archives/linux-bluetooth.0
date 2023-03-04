Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23863C678DB
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Mar 2023 22:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCDWT5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Mar 2023 17:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDWT4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Mar 2023 17:19:56 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2A712F1E
        for <linux-bluetooth@vger.kernel.org>; Sat,  4 Mar 2023 14:19:54 -0800 (PST)
Received: from [192.168.1.195] (91-152-123-43.elisa-laajakaista.fi [91.152.123.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4PTfQs4xdGz49Q3Q;
        Sun,  5 Mar 2023 00:19:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1677968390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6Qlcb/qel9QsgeR6oCvqoaShRWwFl6Grxp5N6Y0gYM=;
        b=Gy0M/UzFMwgPSOXsn6uq5drj0Mm2na9XhipmVdhI4gVKWmLJ1lhQsly/RsiWmWIClt1fJN
        JAzBkvqROHtVObV52sQevPWYbmf9CHMF/jZWBnorfQ6PxeI2v7T8Xx7OKzvk5YTQqBm365
        lZB0DJU5V9z3RDCTGuJnHcJ2Qd9eF3IBU1L0Qn3v3vKpYirH5ygDXzS6b3pVBBvryzF5uN
        MZwTmSoziq8RtyszgX/QjlXodeOSN4mF5b74UKDg7dDkuH+s9LIbrb1wEyEWq6RI2Hr8m4
        EM0I4ylugt/rP799/IWUAmiX4Hv/8J63jwjtvt4Ciur1cgsQJ6VZi6W+kD9+sw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1677968390; a=rsa-sha256;
        cv=none;
        b=XKEzMeNfktvubtrZByBrpZ3KsD8GZ0GEB7GrvDCijCPvmi7R/toEvPFuKnDJz05oTFgfkN
        c4RWWg5S7a/CDtbbtMe3E3L9l2L8/D8R5iE0uui8++7RSSxK7rDTODrlw+Zm44dsHsszKj
        NnvpTaV4ieFxqGPWWk9XpE/A+K7Hv4au029zmFecDTXgB6Ey8YALPuP7WLR8JKF2wC/CyL
        l10sXP1wL5KQIYIo2W8Vtn4BapCBtDN1v/55oi7hBVEbNFD5mfib5AB8AeSmAvgfLL5QwP
        EawhPdAPoHcQeW4H8jb+R8uh0jCaFmLkGpHGA3pZw6SQO68h8CU2UulApc+tjw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1677968390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6Qlcb/qel9QsgeR6oCvqoaShRWwFl6Grxp5N6Y0gYM=;
        b=Ptci202uXxzZnx0vC1jQPZ3hzxFP4YrxTHElXkXQ1V/cWEWpo89lAJEogqgxbOLqypghyh
        DHL8n44njqk5NP3S58ILegkLkcYd6UQ8BuJUf3bE2Gn5RW8sWPybmUa17pvD+9t7xBUiKu
        rBjL3S6rStTYk2Xi17kf6qD/HGrENff3ZTSwBty4A4mTlEbw35ecXp2+IbWjaYEOUVY037
        hUSW0uNffiv04ksZcKOXfn9vBMhLZ2U/jqQcAY87s8r3v0c4eSq/lEX0nUonlhM77lscd+
        M6sViPmtldJ1WWlVOcU4ditCIq3Xo1+KWtgHODvX0+8brMrQlIDHPSVZnaeQLQ==
Message-ID: <83f20e7c05e16d62c6f88eeffeb5306853fd2adb.camel@iki.fi>
Subject: Re: [RFC 3/9] doc: Add set-api
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Sun, 05 Mar 2023 00:19:49 +0200
In-Reply-To: <20230303012742.1386291-3-luiz.dentz@gmail.com>
References: <20230303012742.1386291-1-luiz.dentz@gmail.com>
         <20230303012742.1386291-3-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

to, 2023-03-02 kello 17:27 -0800, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >=20
> > This adds set-api.rst which documents DeviceSet interface.
> > ---
> >  doc/set-api.rst | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 doc/set-api.rst
> >=20
> > diff --git a/doc/set-api.rst b/doc/set-api.rst
> > new file mode 100644
> > index 000000000000..17c5f93b6b86
> > --- /dev/null
> > +++ b/doc/set-api.rst
> > @@ -0,0 +1,53 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +BlueZ D-Bus DeviceSet API description
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +
> > +DeviceSet interface
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Service		org.bluez
> > +Interface	org.bluez.DeviceSet1
> > +Object path	[variable prefix]/{hci0,hci1,...}/set_{sirk}
> > +
> > +Methods
> > +=3D=3D=3D=3D=3D=3D=3D
> > +
> > +**void Connect() [experimental]**
> > +
> > +	Connects all **devices** members of the set, each member is
> > +	connected in sequence as they were added/loaded following the
> > +	same proceedure as described in **Device1.Connect**.
> > +
> > +	Possible errors: org.bluez.Error.NotReady
> > +			 org.bluez.Error.Failed
> > +			 org.bluez.Error.InProgress
> > +			 org.bluez.Error.AlreadyConnected
> > +
> > +**void Disconnect() [experimental]**
> > +
> > +	Disconnects all **devices** members of the set, each member is
> > +	disconnected in sequence as they were connected following the
> > +	same proceedure as described in **Device1.Disconnect**.
> > +
> > +	Possible errors: org.bluez.Error.NotConnected
> > +
> > +Properties
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +**bool AutoConnect [read-write, experimental]**
> > +
> > +	Indicates if the **devices** members of the set shall be automaticall=
y
> > +	connected once any of its members is connected.
> > +
> > +**array(object) Devices [ready-only, experimental]**
> > +
> > +	List of devices objects that are members of the set.
> > +
> > +**byte Size [read-only, experimental]**
> > +
> > +	Set members size.
> > +
> > +**byte Rank [read-only, experimental]**
> > +
> > +	Set members rank.

It looks like rank is supposed to be a property of each set member
device, not a constant property of the set like size.

See CSIS 5.4: "The value of the Set Member Rank characteristic exposed
by servers that are part of the same Coordinated Set shall be
contiguous integers starting from 0x01 to the size of the Coordinated
Set."

So maybe should be something like

**array(byte) Ranks [read-only, experimental]**

	Set member ranks.

--=20
Pauli Virtanen
