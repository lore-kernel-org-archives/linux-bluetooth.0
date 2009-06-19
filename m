Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Jun 2009 16:53:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Douglas Lopes Pereira <douglaslopespereira@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Unable to play music on mobile phone over bluetooth
Message-ID: <20090619135337.GA16901@jh-x301>
References: <e0ab60670906181104m3a0a95cdk13d3d4596ed6676@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e0ab60670906181104m3a0a95cdk13d3d4596ed6676@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 18, 2009, Douglas Lopes Pereira wrote:
> I'm facing some problems while playing music on my N95 phone over a
> bluetooth conection and trying to record it with arecord.
<snip>
> Does anyone has a clue? Can anybody help me and point what I am doing wrong?

I don't think you're doing anything wrong but just something that's not
supported by bluez yet. However, A2DP Sink role is being implemented in
Google SoC this year so if you're patient your use case might become
possible soon.

Johan
