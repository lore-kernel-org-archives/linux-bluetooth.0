Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120117194300.GB29544@x220.P-661HNU-F1>
References: <1326817082-6787-1-git-send-email-anderson.lizardo@openbossa.org>
	<1326817082-6787-3-git-send-email-anderson.lizardo@openbossa.org>
	<20120117194300.GB29544@x220.P-661HNU-F1>
Date: Tue, 17 Jan 2012 15:58:49 -0400
Message-ID: <CAJdJm_MC3sKOTCqfhZpTCc9QS4QHyhvTNCzRyUzV+0LzpNS+=Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] Fix not showing name if first EIR has no name info
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Jan 17, 2012 at 3:43 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Applied. Please do a git pull and check that the eir_parse function is
> now both readable and correct.

After a quick review, it looks correct and more readable. I still need
to test it, but I will have to skip the last mgmt API changes given I
can't update the kernel at the moment.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
