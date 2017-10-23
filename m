Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1508766916.28409.2.camel@hadess.net>
Subject: Re: [PATCH 2/3] profiles/battery: Add Bluetooth LE Battery service
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 23 Oct 2017 15:55:16 +0200
In-Reply-To: <20171020230304.21173-2-hadess@hadess.net>
References: <20171020230304.21173-1-hadess@hadess.net>
         <20171020230304.21173-2-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2017-10-21 at 01:03 +0200, Bastien Nocera wrote:
> Only the Battery Level characteristic was tested with a
> Microsoft Arc Touch Mouse SE.
> 
> This patch however hopes to support both the Battery Level and
> the Battery Power State characteristics.

There might be a bug somewhere in this code which caused devices not to
send updated "Connected" properties when disconnected, I'm debugging
this now.

Comments on the API would be appreciated though.

Cheers
