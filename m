Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308133135.9190.11.camel@air.hadess.net>
References: <BANLkTind9qu33viRE+eSB6b7SiGhr_DTLQ@mail.gmail.com>
	<1307554688-21555-1-git-send-email-hadess@hadess.net>
	<20110614080730.GC28890@dell.ger.corp.intel.com>
	<1308043116.26522.1.camel@air.hadess.net>
	<20110614094338.GA18317@dell.ger.corp.intel.com>
	<1308133135.9190.11.camel@air.hadess.net>
Date: Wed, 15 Jun 2011 09:00:48 -0400
Message-ID: <BANLkTikSdWS+YBjmyGd40GbOP48hs1cxjA@mail.gmail.com>
Subject: Re: [PATCH] adaptername: Move adapter naming into a plugin
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jun 15, 2011 at 6:18 AM, Bastien Nocera <hadess@hadess.net> wrote:
> I *obviously* can't split the original patch in 2 patches and keep the
> code working. Lizardo wanted the simplification of the name setting and
> the adaptername plugin patch to be separate so that we could potentially
> bisect regressions.

"wanted" is a bit too much IMHO. It was a suggestion based on my own
review. In the end it is up to the commiters of the project (Johan &
Marcel ?) to decide whether to accept/reject the patches.

My suggestion was to simply split between "move adapter naming into a
plugin" (like the description of your original patch) and "add support
for pretty hostnames from systemd". Currently both things are done in
a single patch.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
