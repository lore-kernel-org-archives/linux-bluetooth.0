Return-Path: <cyrus@holtmann.org>
Message-Id: <2DF54EBC-78D8-413F-A2D4-2BBC6174D7BD@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <000301c976ff$0a1339e0$1e39ada0$%park@samsung.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: How can I know BlueZ A2DP, AVRCP profile version.?
Date: Thu, 15 Jan 2009 12:01:43 +0100
References: <003501c961aa$588a4100$099ec300$%park@samsung.com> <1229712795.879.6.camel@californication> <460D2014-0925-42BE-A769-697E9795D4A4@gmail.com> <000301c976ff$0a1339e0$1e39ada0$%park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Jan 15, 2009, at 11:50, Chan-Yeol Park wrote:
> Does BlueZ Support A2DP as both Initiator and Acceptor role?

Yes. (after all, they are both mandatory in the spec.)

> As far as I look-up the code , I could find A2DP as only INIT role.

I'm not sure what code you have been looking at but BlueZ does a  
server AVDTP socket and a mechanism for handling incoming AVDTP  
commands (see audio/avdtp.c for more info).

Johan
