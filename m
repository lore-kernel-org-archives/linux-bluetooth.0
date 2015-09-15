Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Sep 2015 10:13:19 +0100
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <gregkh@linuxfoundation.org>, <linaro-kernel@lists.linaro.org>,
        Rafael
 Wysocki <rjw@rjwysocki.net>, <sboyd@codeaurora.org>,
        <arnd@arndb.de>, Mark
 Brown <broonie@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander
 Duyck <alexander.h.duyck@redhat.com>,
        "moderated list:SOUND - SOC LAYER /
 DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Arik
 Nemtsov <arik@wizery.com>,
        "open list:QUALCOMM ATHEROS ATH10K WIRELESS
 DRIVER" <ath10k@lists.infradead.org>,
        "open list:QUALCOMM ATHEROS ATH9K
 WIRELESS DRIVER" <ath9k-devel@lists.ath9k.org>,
        Avri Altman
	<avri.altman@intel.com>,
        "open list:B43 WIRELESS DRIVER"
	<b43-dev@lists.infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian
 Silverman <bsilver16384@gmail.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Chaya Rachel Ivgi <chaya.rachel.ivgi@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        Doug Thompson <dougthompson@xmission.com>,
        Eliad Peller <eliad@wizery.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Florian Fainelli
	<f.fainelli@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Haggai Eran
	<haggaie@mellanox.com>,
        Hariprasad S <hariprasad@chelsio.com>, Ingo Molnar
	<mingo@kernel.org>,
        Intel Linux Wireless <ilw@linux.intel.com>,
        "open
 list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        "James E.J.
 Bottomley" <JBottomley@odin.com>,
        Jaroslav Kysela <perex@perex.cz>, Jiri
 Slaby <jirislaby@gmail.com>,
        Joe Perches <joe@perches.com>, Joerg Roedel
	<joro@8bytes.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Johannes Berg
	<johannes.berg@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan
 Corbet <corbet@lwn.net>, Joonsoo Kim <js1304@gmail.com>,
        Kalle Valo
	<kvalo@qca.qualcomm.com>,
        Larry Finger <Larry.Finger@lwfinger.net>, Len Brown
	<lenb@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:ACPI"
	<linux-acpi@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64
 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
        "open list:BLUETOOTH
 DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "open list:DOCUMENTATION"
	<linux-doc@vger.kernel.org>,
        "open list:EDAC-CORE"
	<linux-edac@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:CISCO SCSI
 HBA DRIVER" <linux-scsi@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB)
 SUBSYSTEM:" <linux-usb@vger.kernel.org>,
        "open list:NETWORKING DRIVERS
 (WIRELESS)" <linux-wireless@vger.kernel.org>,
        Luciano Coelho
	<luciano.coelho@intel.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Mauro Carvalho Chehab
	<mchehab@osg.samsung.com>,
        Mel Gorman <mgorman@suse.de>,
        Michael Kerrisk
	<mtk.manpages@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Narsimhulu Musini
	<nmusini@cisco.com>,
        "open list:CXGB4 ETHERNET DRIVER (CXGB4)"
	<netdev@vger.kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "open
 list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        QCA ath9k Development
	<ath9k-devel@qca.qualcomm.com>,
        Richard Fitzgerald
	<rf@opensource.wolfsonmicro.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sebastian Ott
	<sebott@linux.vnet.ibm.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Stanislaw
 Gruszka <sgruszka@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, Takashi
 Iwai <tiwai@suse.com>,
        Tejun Heo <tj@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vlastimil
 Babka <vbabka@suse.cz>,
        Wang Long <long.wanglong@huawei.com>,
        Will Deacon
	<will.deacon@arm.com>
Subject: Re: [PATCH V3 2/2] debugfs: don't assume sizeof(bool) to be 4 bytes
Message-ID: <20150915091319.GH11200@ck-lbox>
References: <9b705747a138c96c26faee5218f7b47403195b28.1442305897.git.viresh.kumar@linaro.org>
 <27d37898b4be6b9b9f31b90135f8206ca079a868.1442305897.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <27d37898b4be6b9b9f31b90135f8206ca079a868.1442305897.git.viresh.kumar@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 15, 2015 at 02:04:59PM +0530, Viresh Kumar wrote:
> Long back 'bool' type used to be a typecast to 'int', but that changed
> in v2.6.19. And that is a typecast to _Bool now, which (mostly) takes
> just a byte. Anyway, the bool type is implementation defined, and better
> we don't assume its size to be 4 bytes or 1.
> 
> The problem with current code is that it reads/writes 4 bytes for a
> boolean, which will read/update 3 excess bytes following the boolean
> variable (when sizeof(bool) is 1 byte). And that can lead to hard to fix
> bugs. It was a nightmare cracking this one.
> 
> The debugfs code had this bug since the first time it got introduced,
> but was never got caught, strange. Maybe the bool variables (monitored
> by debugfs) were followed by an 'int' or something bigger and the pad
> bytes made sure, we never see this issue.
> 
> But the OPP (Operating performance points) library have three booleans
> allocated to contiguous bytes and this bug got hit quite soon (The
> debugfs support for OPP is yet to be merged). It showed up as corruption
> of the debugfs boolean symbols, where Y were becoming N and vice versa.
> 
> Fix it properly by changing the last argument of debugfs_create_bool(),
> to type 'bool *' instead of 'u32 *', so that it doesn't depend on sizeof
> bool at all.
> 
> That required updates to all user sites as well in a single commit.
> regmap core was also using debugfs_{read|write}_file_bool(), directly
> and variable types were updated for that to be bool as well.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

For the minor wm_adsp change:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
