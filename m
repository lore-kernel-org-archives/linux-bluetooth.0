Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: linux-firmware: Update Intel BT devices firmware patch files (7260/3160)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399888626.879.111.camel@i7.infradead.org>
Date: Mon, 12 May 2014 04:58:32 -0700
Cc: Adam Lee <adam.lee@canonical.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	"An, Tedd" <tedd.an@intel.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"Fry, Don" <don.fry@intel.com>
Message-Id: <FF14C282-376A-4F9B-A191-0F46F42E2D9C@holtmann.org>
References: <20140314135254.2edf9d2e@han1-desk-dev> <1395003913.15764.118.camel@deadeye.wl.decadent.org.uk> <BB52B9B497F0EE4EB05C192A0408F6602F27F4AD@ORSMSX104.amr.corp.intel.com> <1396829760.13361.19.camel@deadeye.wl.decadent.org.uk> <20140512094137.GB3503@adam-laptop> <1399888626.879.111.camel@i7.infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

>>>>>> File: intel/ibt-hw-37.7.bseq
>>>>>> Version: 1316.02.00
>>>>>> File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
>>>>>> -Version: 1344.01.33
>>>>>> +Version: auto.WP_1303_02_patch_0.1.54.1 (0x36)
>>>>>> File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
>>>>>> -Version: 1344.01.33
>>>>>> +Version: auto.WP_1303_02_patch_0.1.54.1 (0x36)
>>>>> [...]
>>>>> 
>>>>> Why has the version format changed?  Are all the different parts actually
>>>>> significant?
>>> [...]
>>> 
>>> That doesn't answer the second question.
>>> 
>>> I really have a hard time believing that all of 'auto.WP', '1303_02',
>>> 'patch', '0.1.54.1' and '0x36' are all significant.  No-one else seems
>>> to need more than 4 components in a version number; what's so special
>>> about this firmware?
>>> 
>>> And another question: can an outside observer compare version strings
>>> and get any sense of which is newer?  Are the components in the right
>>> order (most significant first)?
>>> 
>>> Ben.
>> 
>> Hi, all
>> 
>> This firmware also fixes another EHCI HSP/HFP profile not working issue,
>> could you guys please reach a consensus about the version string and get
>> it upstreamed?
> 
> I don't care as much about the version number. Even Ben's question about
> which is newer isn't that interesting to me. With closed-source firmware
> you never know that newer is *better*, and you often end up deliberately
> staying on old versions.
> 
> I'm more bothered by all the crap in the filename. That ought to be
> considered equivalent to the soname in a dynamically linked library — it
> specifies the ABI (and the specific hardware). And it looks like the
> *filename* has more version-cruft in it than it should have. But that's
> a separate issue and it isn't being changed in this patch. It should
> ideally have been caught when the file was originally added.

these are ROM patches. All the version magic in the filename allows the generic kernel driver to pick the right file for whatever ROM version of the chip you might have on your system. Since this is not a full RAM firmware, you need to load the right file matching your current hardware. Otherwise it will not work.

Maybe some of these version digits will not change in practice, but we do not know this. However the numbers come straight from the Intel version command from the btusb.ko driver. In case anybody cares.

struct intel_version {
        u8 status;
        u8 hw_platform;
        u8 hw_variant;
        u8 hw_revision;
        u8 fw_variant;
        u8 fw_revision;
        u8 fw_build_num;
        u8 fw_build_ww;
        u8 fw_build_yy;
        u8 fw_patch_num;
} __packed;

Regards

Marcel

