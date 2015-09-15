Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Sep 2015 19:34:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	"sboyd@codeaurora.org" <sboyd@codeaurora.org>,
	"arnd@arndb.de" <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Alexander Duyck <alexander.h.duyck@redhat.com>,
	"moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Arik Nemtsov <arik@wizery.com>,
	"open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,
	"open list:QUALCOMM ATHEROS ATH9K WIRELESS DRIVER" <ath9k-devel@lists.ath9k.org>,
	"Altman, Avri" <avri.altman@intel.com>,
	"open list:B43 WIRELESS DRIVER" <b43-dev@lists.infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Silverman <bsilver16384@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
	"Ivgi, Chaya Rachel" <chaya.rachel.ivgi@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dmitry Monakhov <dmonakhov@openvz.org>,
	Doug Thompson <dougthompson@xmission.com>,
	Eliad Peller <eliad@wizery.com>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Gustavo Padovan <gustavo@padovan.org>,
	Haggai Eran <haggaie@mellanox.com>,
	Hariprasad S <hariprasad@chelsio.com>,
	Ingo Molnar <mingo@kernel.org>,
	Intel Linux Wireless <ilw@linux.intel.com>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
	"James E.J. Bottomley" <JBottomley@odin.com>,
	Jaroslav Kysela <perex@perex.cz>, Jiri Slaby <jirislaby@gmail.com>,
	Joe Perches <joe@perches.com>, Joerg Roedel <joro@8bytes.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Joonsoo Kim <js1304@gmail.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Len Brown <lenb@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	"open list:CISCO SCSI HBA DRIVER" <linux-scsi@vger.kernel.org>,
	"open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb@vger.kernel.org>,
	"open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>,
	"Coelho, Luciano" <luciano.coelho@intel.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Mel Gorman <mgorman@suse.de>,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Narsimhulu Musini <nmusini@cisco.com>,
	"open list:CXGB4 ETHERNET DRIVER (CXGB4)" <netdev@vger.kernel.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	"open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>,
	Peter Zijlstra <peterz@infradead.org>,
	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
	Richard Fitzgerald <rf@opensource.wolfsonmicro.com>,
	Sasha Levin <sasha.levin@oracle.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Stanislaw Gruszka <sgruszka@redhat.com>,
	Takashi Iwai <tiwai@suse.com>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Winkler, Tomas" <tomas.winkler@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Wang Long <long.wanglong@huawei.com>,
	Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V3 2/2] debugfs: don't assume sizeof(bool) to be 4 bytes
Message-ID: <20150915140436.GJ6350@linux>
References: <9b705747a138c96c26faee5218f7b47403195b28.1442305897.git.viresh.kumar@linaro.org>
 <27d37898b4be6b9b9f31b90135f8206ca079a868.1442305897.git.viresh.kumar@linaro.org>
 <1442313464.1914.21.camel@sipsolutions.net>
 <20150915110447.GI6350@linux>
 <20150915094509.46cca84d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150915094509.46cca84d@gandalf.local.home>
List-ID: <linux-bluetooth.vger.kernel.org>

On 15-09-15, 09:45, Steven Rostedt wrote:
> Then break up the patch.

That will cause build warnings between the patches due to prototype
mismatch. Maybe I should ignore get_maintainers for this patch and
just cc the lists :)

> Your Cc list is far too large, I would nack
> this patch just for that alone.

:(

> Sad part is, you didn't even Cc Linus (which I added). I believe he was
> against having bool's in structures before.

Sorry about that, I had no clue that I should explicitly include Linus
to this thread.

> Linus, This patch changes a lot of u32s into bools in structures.
> What's your take on that?
> 
> I added the patch again to the bottom of this email so that Linus may
> see it (it was cut from the email I'm replying to).

Thanks Steven.

-- 
viresh
