Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/11] Socket HAL updates
Date: Wed, 12 Feb 2014 13:55:14 +0100
Message-ID: <2945125.BRLiNtsqBu@leonov>
In-Reply-To: <20140212095739.GA25950@aemeltch-MOBL1>
References: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com> <20140212095739.GA25950@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 12 of February 2014 11:57:41 Andrei Emeltchenko wrote:
> Hi Andrzej,
> 
> On Tue, Feb 11, 2014 at 05:58:10PM +0100, Andrzej Kaczmarek wrote:
> > Hi,
> > 
> > Current socket HAL implementation is missing major feature which is
> > ability to register RFCOMM server from application (so use some UUID
> > and assign channel number dynamically). This corresponds to
> > BluetoothAdapter::listenUsing(insecure)RfcommWithServiceRecord APIs
> > in Android.
> 
> Support dynamic RFCOMM sockets looks god though I do not know why renaming
> of socket names is really needed.

I find new names a bit easier to understand and this is now applied.

-- 
BR
Szymon Janc
