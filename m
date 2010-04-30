Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Apr 2010 05:03:19 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: ofono@ofono.org
Subject: Re: Modem emulator and DUN server side for oFono and BlueZ
Message-ID: <20100430080319.GA11712@vigoh>
References: <33AB447FBD802F4E932063B962385B351D9FE1FA@shsmsx501.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <33AB447FBD802F4E932063B962385B351D9FE1FA@shsmsx501.ccr.corp.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Reply-To: ofono@ofono.org
List-Unsubscribe: <http://lists.ofono.org/options/ofono>,
	<mailto:ofono-request@ofono.org?subject=unsubscribe>
List-Archive: <http://lists.ofono.org/pipermail/ofono>
List-Post: <mailto:ofono@ofono.org>
List-Help: <mailto:ofono-request@ofono.org?subject=help>
List-Subscribe: <http://lists.ofono.org/listinfo/ofono>,
	<mailto:ofono-request@ofono.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: ofono-bounces@ofono.org
Errors-To: ofono-bounces@ofono.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zhenhua,

* Zhang, Zhenhua <zhenhua.zhang@intel.com> [2010-04-27 15:53:54 +0800]:

> Hi,
> 
> I am now working on modem emulator and one usage is for DUN server role. Since Padovan is working on client role, it's good to share my rough thinking for server side implementation. Here are the simple steps I have:
> 
> 1. Create an oFono emulator atom in oFono. It's the emulator manager that could create DUN, HFP AG or SPP type emulators. It exposes dbus methods like CreateEmulator, DestroyEmulator, GetProperty, etc.
> 
> 2. DUN agent server in BlueZ watch oFono and call CreateEmulator and pass the file descriptor to oFono. This server could further implement HFP AG and SPP connection.


Shouldn't the emulator register itself on the BlueZ agent server?


-- 
Gustavo F. Padovan
http://padovan.org
_______________________________________________
ofono mailing list
ofono@ofono.org
http://lists.ofono.org/listinfo/ofono
