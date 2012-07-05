Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1340878959-1343-12-git-send-email-michal.labedzki@tieto.com>
References: <1340878959-1343-1-git-send-email-michal.labedzki@tieto.com>
	<1340878959-1343-12-git-send-email-michal.labedzki@tieto.com>
Date: Thu, 5 Jul 2012 13:05:09 +0300
Message-ID: <CABBYNZKEMguHRQ8RDfKaABouS5ZLW+3DoMeXcLKmxREr9yg41w@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] AVRCP: Use NoAvailablePlayers status code for
 AVRCP 1.4 devices
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, lucas.demarchi@profusion.mobi,
	johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Thu, Jun 28, 2012 at 1:22 PM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> DummyPlayer indicate there is no available players. For AVRCP 1.4
> devices use NoAvailblePlayers status code, on the other side, for
> AVRCP 1.3 devices use InternalError.

For reporting errors alone I don't think we really need a dummy
player, in the other hand it seems that some device (MW600) will just
stop doing anything regarding player events if it gets an error, in
that case dummy can be useful because it serves as a place holder than
once a player is registered it automatically takes place of the dummy
one so we don't need the player to be registered during boot or
anything like.

-- 
Luiz Augusto von Dentz
