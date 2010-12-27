Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <anderson.lizardo@openbossa.org>
CC: <linux-bluetooth@vger.kernel.org>
Date: Mon, 27 Dec 2010 16:35:04 +0200
Subject: Re: [PATCH 2/4] Two merges very similar functions in bluetooth.c
Message-ID: <E50901D4F2CF69428D43141B7C8586790B4B2D056C@EXMB03.eu.tieto.com>
References: <1293447745-8697-1-git-send-email-michal.labedzki@tieto.com>
	<1293447745-8697-2-git-send-email-michal.labedzki@tieto.com>,<AANLkTik-sV2+k8_j6xt5F1MAPb-7t9K8JTEzm12f--c4@mail.gmail.com>
In-Reply-To: <AANLkTik-sV2+k8_j6xt5F1MAPb-7t9K8JTEzm12f--c4@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Dec 27, 2010, Anderson Lizardo wrote:
> IMHO, you should keep str2ba and drop the few occurrences of
> strtoba(). Same applies to ba2str/batostr.

> strtoba() allocates memory by itself, so if you use it instead, you
> need to deallocate memory. str2ba(), on the other hand, uses a buffer
> given as argument.

These function are similar, but not the same. ba2str/str2ba reverse bdaddr, but
batostr/strtoba not. I wrote relevant documentation comments, because names look
similar, code look similar, but results are different.

Regards