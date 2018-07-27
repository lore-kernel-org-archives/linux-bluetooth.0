Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <b22c52f2a72344e284ad555b13526f7f887354de.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/2] core: Add AlwaysPairable to main.conf
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Fri, 27 Jul 2018 16:17:43 +0200
In-Reply-To: <20180727130218.16975-1-luiz.dentz@gmail.com>
References: <20180727130218.16975-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2018-07-27 at 16:02 +0300, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds a new option called AlwaysPairable to main.conf, it can be
> used to enable Adapter.Pairable even in case there is no Agent
> available.
> 
> Since that could be consider a security problem to allow pairing
> without user's consent the option defaults to false.

This seems to work as expected. After disabling the agent in
bluetoothctl, and making the adapter discoverable, I can't start a
pairing from an iPhone, as was tested.
