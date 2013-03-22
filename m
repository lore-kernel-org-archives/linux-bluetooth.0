Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1363905109-30839-3-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
	<1363905109-30839-3-git-send-email-alvaro.silva@openbossa.org>
Date: Thu, 21 Mar 2013 21:06:02 -0400
Message-ID: <CAJdJm_MDdOqHGfJ4ePRjug_yv9f3Zp9_f-W10dvxMjGbdNzjtg@mail.gmail.com>
Subject: Re: [PATCH 02/13] gatttool: Remove programming error check
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Alvaro Silva <alvaro.silva@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Eder Ruiz Maria <eder.ruiz@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Mar 21, 2013 at 6:31 PM, Alvaro Silva
<alvaro.silva@openbossa.org> wrote:
> From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

Just to clarify (IMHO the commit message is incomplete): this check is
removed here because it is more appropriate to be done by callers of
gatt_connect(). This is already done on interactive mode in
attrib/interactive.c and is now also done in non-interactive mode on
patch 03/13.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
