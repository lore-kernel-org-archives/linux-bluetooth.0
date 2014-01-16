Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/bluetooth: Fix discovering new devices
Date: Thu, 16 Jan 2014 15:50:36 +0100
Message-ID: <1502325.Jt3PyHcn9k@uw000953>
In-Reply-To: <20140116135032.GA1267@x220.p-661hnu-f1>
References: <1389879325-21217-1-git-send-email-szymon.janc@tieto.com> <20140116135032.GA1267@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thursday 16 of January 2014 15:50:32 Johan Hedberg wrote:
> Hi Szymon,
> 
> On Thu, Jan 16, 2014, Szymon Janc wrote:
> > @@ -983,12 +994,15 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
> >  	eir_parse(&eir, data, data_len);
> >  
> >  	dev = find_device(bdaddr);
> > -	if (!dev) {
> > +	if (!dev || !dev->found) {
> 
> I think this would still deserve a code comment here explaining why
> dev->found is important. Other than that the patch is fine, so feel free
> to push it yourself once you've added the comment.

Pushed.

-- 
Best regards, 
Szymon Janc
