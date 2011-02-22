Return-Path: <cyrus@holtmann.org>
Subject: Re: How to config bluetooth headset ?
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: "Daniel O'Connor" <doconnor@gsoft.com.au>
In-Reply-To: <AANLkTinC4JqX627rv7PUWrhOZwmerCEQJ_jeZ0w29LW9@mail.gmail.com>
Date: Tue, 22 Feb 2011 19:51:28 +1030
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5BC4F68C-A168-4C70-8FB2-A4D2BFBB347D@gsoft.com.au>
References: <AANLkTinC4JqX627rv7PUWrhOZwmerCEQJ_jeZ0w29LW9@mail.gmail.com>
To: Bob Liu <lliubbo@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 22/02/2011, at 18:09, Bob Liu wrote:
> Cureently I can scan the device:
> # hcitool scan
> Scanning ...
>        00:1A:45:4A:EA:39       Jabra BT125
> #
> 
> How to make aplay can use that device?

Does bluetooth-wizard help you?

I don't know if there is a command line equivalent though, or what happens afterward - eg if bluetoothd stores the connection info for later use or something else must be run..

--
Daniel O'Connor software and network engineer
for Genesis Software - http://www.gsoft.com.au
"The nice thing about standards is that there
are so many of them to choose from."
  -- Andrew Tanenbaum
GPG Fingerprint - 5596 B766 97C0 0E94 4347 295E E593 DC20 7B3F CE8C






