Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330613135-16552-2-git-send-email-michal.labedzki@tieto.com>
References: <1330613135-16552-1-git-send-email-michal.labedzki@tieto.com>
	<1330613135-16552-2-git-send-email-michal.labedzki@tieto.com>
Date: Thu, 1 Mar 2012 17:34:19 +0200
Message-ID: <CABBYNZL5go4LSXbzx5qyEDg2quMqNJ+n+A+qsL+ybSv99FzPyg@mail.gmail.com>
Subject: Re: [PATCH 2/3] avrcp: Add error code for rejected vendor command
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com,
	vani.patel@stericsson.com, joohi.rastogi@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Thu, Mar 1, 2012 at 4:45 PM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> Make correct response for any vendor commands when there are not any
> registered player. According to the specification responses should be
> REJECTED with error code.

Please quote the spec whenever possible, actually what spec does this come from?


-- 
Luiz Augusto von Dentz
