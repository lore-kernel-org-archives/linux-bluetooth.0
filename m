Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349781598-22580-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1349781598-22580-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Tue, 9 Oct 2012 10:15:36 -0400
Message-ID: <CAJdJm_OyXnCunC0OfiGACQMTdaN0LJj+3FXXTtcz5Qtgzka5hg@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Thermometer watchers API change + fixes
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, Oct 9, 2012 at 7:19 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> Also this was tested with PTS 4.5.3 and works fine now after memset fix,
> except for TP/THF/CO/BI-07-I which seems to have issue in PTS (there should
> be reserved value for temperature type but PTS sends 0x02 which is
> perfectly valid value thus it won't be discarded on our side).

BTW, you can open a ticket for fixing this in PTS. They are usually
fast in fixing things (but not so fast on delivering new releases).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
