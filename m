Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1293447745-8697-3-git-send-email-michal.labedzki@tieto.com>
References: <1293447745-8697-1-git-send-email-michal.labedzki@tieto.com>
	<1293447745-8697-3-git-send-email-michal.labedzki@tieto.com>
Date: Mon, 27 Dec 2010 07:53:58 -0400
Message-ID: <AANLkTikD4S-rD+NCXs7URSYv3Ah=-uToEw4YyCP4cA5x@mail.gmail.com>
Subject: Re: [PATCH 3/4] Fix memory leaks after using strtoba, batostr
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch would not be necessary if you keep only str2ba() and
ba2str() (like I commented on patch 2/4).

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
