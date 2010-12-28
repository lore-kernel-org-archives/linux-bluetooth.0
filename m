Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <anderson.lizardo@openbossa.org>
CC: <linux-bluetooth@vger.kernel.org>
Date: Tue, 28 Dec 2010 11:34:27 +0200
Subject: Re: [PATCH 3/4] Fix memory leaks after using strtoba, batostr
Message-ID: <E50901D4F2CF69428D43141B7C8586790B4B2D0570@EXMB03.eu.tieto.com>
References: <1293447745-8697-1-git-send-email-michal.labedzki@tieto.com>
	<1293447745-8697-3-git-send-email-michal.labedzki@tieto.com>,<AANLkTikD4S-rD+NCXs7URSYv3Ah=-uToEw4YyCP4cA5x@mail.gmail.com>
In-Reply-To: <AANLkTikD4S-rD+NCXs7URSYv3Ah=-uToEw4YyCP4cA5x@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


>Hi,
>
>This patch would not be necessary if you keep only str2ba() and
>ba2str() (like I commented on patch 2/4).
>
>Regards,

Cannot keep only *2*() functions, because for two reason. Firstly, these functions are different (see discussion at patch 2/4). 
Secondly, for example, "ba2str" use external buffer, while "batostr" create it internal. So simpler is using "batostr", 
because there is no need to create temporary buffer.

So I think patch is (quite) useful.

Regards