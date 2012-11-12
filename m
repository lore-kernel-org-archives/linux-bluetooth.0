Return-Path: <cyrus@holtmann.org>
Message-ID: <50A14FAE.2020405@elbrys.com>
Date: Mon, 12 Nov 2012 14:36:14 -0500
From: Bart Westgeest <bart@elbrys.com>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Feedback on potential fix for issue while advertising Feature
 List
References: <509BD103.2040808@elbrys.com> <509D879C.1080205@elbrys.com> <20121110122535.GA26532@x220.P-661HNU-F1>
In-Reply-To: <20121110122535.GA26532@x220.P-661HNU-F1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> I think the option of looking at the length and using the old
> type for < 256 and a 16-bit type for greater lengths would be the
> safest.

Thanks for the feedback. I'll start working on a patch.
