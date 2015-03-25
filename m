Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BAY176-W2D78A6F5517165B5BEDAED30B0@phx.gbl>
References: <BAY176-W2D78A6F5517165B5BEDAED30B0@phx.gbl>
Date: Wed, 25 Mar 2015 15:27:42 +0200
Message-ID: <CABBYNZ+SEMRS-ogz_Czje_OgGj5=QD=gC2dhAopcVZ519Jj0mw@mail.gmail.com>
Subject: Re: Heartrate monitor profile
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ssagarr Patil <hugarsagar@outlook.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sagar,

On Wed, Mar 25, 2015 at 2:11 PM, Ssagarr Patil <hugarsagar@outlook.com> wrote:
> Hi,
>
> Are there any sample apps demonstrating heart rate monitoring using bluez5 ?

As a client/central or server/peripheral? For the former we have a
plugin that expose the following API:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/heartrate-api.txt

But I think we will probably deprecate this in favor of generic GATT
API since heartrate does not require tight integration.


-- 
Luiz Augusto von Dentz
