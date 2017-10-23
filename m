Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1508796837.28409.5.camel@hadess.net>
Subject: Re: [PATCH v2 3/3] profiles/battery: Remove unused bas.[ch]
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 24 Oct 2017 00:13:57 +0200
In-Reply-To: <CABBYNZLJabUx4LJK-bhMekYx1SNS79U1y0J+7KcSCN6g8X_wYQ@mail.gmail.com>
References: <20171023154814.20607-1-hadess@hadess.net>
         <20171023154814.20607-3-hadess@hadess.net>
         <CABBYNZLJabUx4LJK-bhMekYx1SNS79U1y0J+7KcSCN6g8X_wYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2017-10-23 at 23:39 +0300, Luiz Augusto von Dentz wrote:
> Hi Bastian,
> 
> On Mon, Oct 23, 2017 at 6:48 PM, Bastien Nocera <hadess@hadess.net>
> wrote:
> > The Battery Service characteristics are not children of the HoG
> > characteristics, so there's nothing to consume in the input
> > profile.
> > Remove that code which duplicated most of the battery profile
> > plugin.
> 
> Id rather not do this, we actually do intend the maintain a small
> helper library that can be unit tested, what bt_bas lacks is just
> proper support of bt_gatt_client nothing else. Also for the record
> this would probably break BfA HoG qualification which requires
> battery
> service to be supported as well, Android code does not have any other
> bas implementation.

That's fine, we can leave this file around. What about the other
patches?
