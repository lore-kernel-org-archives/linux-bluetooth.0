Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v6pqzZHum1-1_SzUWNgsn4C6joYSBDghB_cLe7wwCRbFQ@mail.gmail.com>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
	<CABBYNZLG9E46Ls1Rtj76OKNb1bFnPvM89Ru3EtXZsV0A+sffGQ@mail.gmail.com>
	<CAMOw1v6pqzZHum1-1_SzUWNgsn4C6joYSBDghB_cLe7wwCRbFQ@mail.gmail.com>
Date: Thu, 21 Jul 2011 10:11:56 +0300
Message-ID: <CABBYNZLfh1dwn9jeDSnbvjrvN8-QdywnTbxGngdbCcRCvQP6yg@mail.gmail.com>
Subject: Re: [RFC 00/19] Implement AVRCP 1.3 profile - TG role
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Jul 20, 2011 at 3:55 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
>> I think we might need an agent API anyway, since MPRIS players might
>> be siting in the session bus so bluetoothd cannot really connect to
>> them directly, in the other hand there is nothing preventing someone
>> to write an agent that uses MPRIS to talk to players.
>
> In that case, the agent could perfectly talk to our D-Bus interface
> and use MPRIS to talk to players. Or use MPRIS on both ends.

Yep, but I think we don't want to use agents as proxy because D-Bus
round trips are expensive and sometimes we need to contact the agent
to respond to a request.

-- 
Luiz Augusto von Dentz
