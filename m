Return-Path: <cyrus@holtmann.org>
From: "Xu, Martin" <martin.xu@intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Liu, Bing Wei" <bing.wei.liu@intel.com>,
	"Gao, Bin" <bin.gao@intel.com>,
	"Yin, Kangkai" <kangkai.yin@intel.com>
Date: Wed, 8 Apr 2009 11:02:44 +0800
Subject: RE: patch to fix a2dp issue
Message-ID: <9F0C1DB20AFA954FA1DA05309350433D5B19E457@pdsmsx503.ccr.corp.intel.com>
References: <1238730552-3765-1-git-send-email-forrest.zhao@gmail.com>
 <20090403201207.GA8156@jh-x301>
 <ac8af0be0904031748u4b109e11kb78a1db3d50ead71@mail.gmail.com>
 <9F0C1DB20AFA954FA1DA05309350433D5B0B91CC@pdsmsx503.ccr.corp.intel.com>
 <20090407061728.GA9223@jh-x301>
In-Reply-To: <20090407061728.GA9223@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for your response.
But we can not always leave the a2dp feature as broken. I used the latest aplay application which is from alsa project(alsa-utils) to test the a2dp feature. That shows the application part, at least ALSA part is not fixed.
In my opinions, if the effort is not big, can we fix it at bluez alsa plugin? At least, it is the alsa plugin and it should comply with the interface although the interface keeps changing.:)
