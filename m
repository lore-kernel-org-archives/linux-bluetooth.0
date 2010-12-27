Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1293447745-8697-2-git-send-email-michal.labedzki@tieto.com>
References: <1293447745-8697-1-git-send-email-michal.labedzki@tieto.com>
	<1293447745-8697-2-git-send-email-michal.labedzki@tieto.com>
Date: Mon, 27 Dec 2010 07:46:18 -0400
Message-ID: <AANLkTik-sV2+k8_j6xt5F1MAPb-7t9K8JTEzm12f--c4@mail.gmail.com>
Subject: Re: [PATCH 2/4] Two merges very similar functions in bluetooth.c
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Dec 27, 2010 at 7:02 AM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> in lib/bluetooth.c merge "str2ba" and "strtoba", "ba2str" and "batostr"

IMHO, you should keep str2ba and drop the few occurrences of
strtoba(). Same applies to ba2str/batostr.

strtoba() allocates memory by itself, so if you use it instead, you
need to deallocate memory. str2ba(), on the other hand, uses a buffer
given as argument.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
