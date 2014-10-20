Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2CF57A644018A745B8FE029C7223E16E11964A9B@SHSMSX104.ccr.corp.intel.com>
References: <2CF57A644018A745B8FE029C7223E16E11964A9B@SHSMSX104.ccr.corp.intel.com>
Date: Mon, 20 Oct 2014 12:02:55 +0300
Message-ID: <CABBYNZKoNVhj91NQ1e3PF2ORaAcMs4NsX300bj0cLic1=Joicw@mail.gmail.com>
Subject: Re: Use HFP as sco sink and source at the same time
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Zheng, Wu" <wu.zheng@intel.com>
Cc: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 20, 2014 at 11:15 AM, Zheng, Wu <wu.zheng@intel.com> wrote:
> Hi Luiz,
>
> HFP is used on IVI and meet some issues.
>
> EXACT STEPS LEADING TO PROBLEM:
> ===========================================================
> 1. pair BT phone by bluetoothctl
> 2. launch dialer app
> 3. make voice call and answer, the voice can be heard from IVI speaker
> 4. pair and connect BT headset with bluetoothctl
>
> EXPECTED OUTCOME:
> ===================
> Voice send out from the BT headset
> ACTUAL OUTCOME
> ===================
> sound still heard from IVI speaker, doesn't auto switch to BT handset
>
> I don't make sure if Bluez can support it or not?
>
> Question: the SCOs connection of HFP on IVI can be used as SCO sink and source at the same time?
>
> It is the issue of https://bugs.tizen.org/jira/browse/TC-160.

Yes, by design it is duplex so both sink and source works
simultaneously, perhaps you are talking about of sending the
microphone data to the other end which has probably nothing to do with
Bluetooth but with audio routing not being properly configured.


-- 
Luiz Augusto von Dentz
