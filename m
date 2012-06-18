Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E50901D4F2CF69428D43141B7C85867929DD8AD28C@EXMB03.eu.tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
	<1338998771-18683-4-git-send-email-michal.labedzki@tieto.com>
	<CABBYNZ+Jd9WNftEsrxj93oLgPt8GNAd2eFdoQVWj3g0favoiTA@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C85867929DD8AD28C@EXMB03.eu.tieto.com>
Date: Mon, 18 Jun 2012 14:07:02 +0300
Message-ID: <CABBYNZ+T8K8jP+B1_N=mLzxtZGL-TKcWyxU0GjvErzXoZ2ptRw@mail.gmail.com>
Subject: Re: [PATCH 04/13] AVRCP: Keep AVRCP version of connected device in server
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal.Labedzki@tieto.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Mon, Jun 18, 2012 at 1:30 PM,  <Michal.Labedzki@tieto.com> wrote:
> Hi Luiz,
>
>> The idea is fine, but this is not the server version, it is the
>> version used in the connection so it probably need to be stored in
>> avrcp_player. If there remote doesn't support AVRCP 1.3 or latter we
>> don't need to assign a player.
>
> Ok. This is "remote_version" - remote controller version of AVRCP.Therefore on (new) connection this version will be updated.
> avrcp_player is not good place for that, because connection is only one, so version is the same for all players, but players may be for example 67.
> So maybe only fix the name will be ok. What do you think?

Then perhaps have another structure e.g. avrcp_session that represents
the connection where this information can be stored.

-- 
Luiz Augusto von Dentz
