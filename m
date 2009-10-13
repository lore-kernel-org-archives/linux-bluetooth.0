Return-Path: <cyrus@holtmann.org>
Message-ID: <4AD430D0.3010109@pardus.org.tr>
Date: Tue, 13 Oct 2009 10:48:32 +0300
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
MIME-Version: 1.0
To: alok barsode <alokbarsode@gmail.com>
CC: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: Undefined symbols in netlink plugin
References: <4AB94E32.8060703@pardus.org.tr> <4AD2D155.8040008@pardus.org.tr> <8b5debfa0910120137o70880775le9dfcdede454d40f@mail.gmail.com>
In-Reply-To: <8b5debfa0910120137o70880775le9dfcdede454d40f@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

alok barsode wrote On 12-10-2009 11:37:
> The following patch fixes this issue but I am not sure if its the right way.
> Let Marcel take a call on this.
>
>   
Yes that fixed it. BTW, is it normal to get messages like

Failed to find Bluetooth netlink family
Failed to init netlink plugin

Does the netlink support really exist?
