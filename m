Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <480687D4EEFE7447A2E09AADFF667362049EE77C@nasanexd02c.na.qualcomm.com>
References: <480687D4EEFE7447A2E09AADFF667362049EE77C@nasanexd02c.na.qualcomm.com>
Date: Thu, 21 Jul 2011 21:17:29 +0300
Message-ID: <CABBYNZJqJxJaiJVczPFyOdwtJsRwhCCRqJg5b+ChzSdPJRL5bg@mail.gmail.com>
Subject: Re: bluez d-bus signal to traclk ACL link
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Sumangala, Suraj" <surajs@qca.qualcomm.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 21, 2011 at 4:31 PM, Sumangala, Suraj
<surajs@qca.qualcomm.com> wrote:
> Hi,
>
> Is there any bluez d-bus signal available to track if a local adapter is ACL connected to any remote device?

Sure, there is take a look at Connected property:
http://git.kernel.org/?p=bluetooth/bluez.git;a=blob;f=doc/device-api.txt;h=d1feb1823362b06cebbe3240b15618bd0944c24c;hb=HEAD


-- 
Luiz Augusto von Dentz
