Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120330102545.GB9799@x220>
References: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
	<1332881029-1732-1-git-send-email-anderson.lizardo@openbossa.org>
	<1332881029-1732-9-git-send-email-anderson.lizardo@openbossa.org>
	<20120330102545.GB9799@x220>
Date: Mon, 2 Apr 2012 09:56:49 -0400
Message-ID: <CAJdJm_MyR7HtQxbK_WyOPmSd+bXW6Um9xDafxRkmbywN0uh3YA@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ 8/8] gattrib: Protect GAttrib when there is a
 pending write
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Mar 30, 2012 at 6:25 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> So I'll be awaiting v3's of patch 5 and 8.

Just sent fixed versions. I also did a small refactor to patch 5 to
remove the nested if(). Hope that makes the code clearer.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
