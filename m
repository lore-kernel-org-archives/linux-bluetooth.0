Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <66BD268F973E3544A665E5F503FB38B71AE959AEC1@DC01.bmw-carit.intra>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1331559165-28367-6-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZKKWhEXvULPUpTp6bRPfUV+QeX2nVZbdNJVPFFL6mSPvw@mail.gmail.com>
	<66BD268F973E3544A665E5F503FB38B71AE959AEC1@DC01.bmw-carit.intra>
Date: Mon, 19 Mar 2012 14:58:33 -0300
Message-ID: <CABBYNZLJXUQR970tyU1EAu3inm3cGoWdjHTFng5QBihY-rv6=g@mail.gmail.com>
Subject: Re: [PATCH obexd v0 05/11] client: transfer api merges put and get
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <Mikel.Astiz@bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Mar 19, 2012 at 11:55 AM, Mikel Astiz <Mikel.Astiz@bmw-carit.de> wrote:
> The main problem with this is that, when you want both file-based and memory-based transfers (see patch v0 07/11), you would have 4 possible combinations.

I guess we can always use temporary files, anyway if the filename is
not set than it means the transfer will be buffered.

> Another (less relevant) reason is that some client code could be interested in checking this field. For example the agent needs to know that currently.
>
> I would even propose we make this field public in D-Bus in the future, so it would be weird that you have less information in the internal api.

Well usually the session should know what direction it is since it is
queuing them, we can even have a field inside pending_request for that
although the callback could be use for that purpose. As for the
internal API, transfer should also know what direction it is, right
now what is missing is knowing before it gets started what the
direction would be but this can be solved with
register_get/register_put. Actually if we have a transfer_start we can
make transfer_put and transfer_get to internally call
transfer_registration, of course the parameters would have to be
changed as well.

-- 
Luiz Augusto von Dentz
