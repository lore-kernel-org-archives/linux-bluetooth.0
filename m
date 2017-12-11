Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1513030405.4454.51.camel@ewol.com>
Subject: Re: [PATCH 2/3] mesh: meshctl: Add commands
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Steve Brown <sbrown@cortland.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 11 Dec 2017 15:13:25 -0700
In-Reply-To: <CABBYNZJB-j5+LF5TY+j=MJEc9YMPvSXyEh4spUSd7O_-eQ4ikA@mail.gmail.com>
References: <20171211145839.19573-1-sbrown@cortland.com>
         <20171211145839.19573-3-sbrown@cortland.com>
         <CABBYNZJB-j5+LF5TY+j=MJEc9YMPvSXyEh4spUSd7O_-eQ4ikA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, 2017-12-11 at 13:12 -0200, Luiz Augusto von Dentz wrote:
> Hi Steve,
> 
> On Mon, Dec 11, 2017 at 12:58 PM,  <sbrown@cortland.com> wrote:
> > From: Steve Brown <sbrown@cortland.com>
> > 
> > Get/Set Proxy
> > Get/Set Ident
> > Get/Set Relay
> > Set Heartbeat
> > Get Publication
> > Get/Set Subscription
> 
> Ive split these into individual patches for command and then add in
> the description what the expected output, etc. Btw I think it would
> be
> better to switch from get-set style to cmd [value], so if there is no
> arguments then it just read the value, that way reduce the amount of
> commands and also make the autocomplete a lot more useful since the
> commands shall start with something other than set/get.
> 

I have the individual command patches ready to go along with the
examples and sample output.

Can you review patch 1/3 gatt.c patch?

It's required for the command patches to work.

I'll follow up with a separate patch to add the subscriptions to the 
node and json database.

Steve

