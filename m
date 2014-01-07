Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Jan 2014 12:18:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/pan: Register Network Access Point
Message-ID: <20140107101842.GA20861@x220.p-661hnu-f1>
References: <1389043592-5616-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1389043592-5616-2-git-send-email-ravikumar.veeramally@linux.intel.com>
 <20140107085930.GB9155@x220.p-661hnu-f1>
 <52CBCF93.7060604@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52CBCF93.7060604@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Jan 07, 2014, Ravi kumar Veeramally wrote:
> >>@@ -49,7 +54,7 @@
> >>  static bdaddr_t adapter_addr;
> >>  GSList *devices = NULL;
> >>  uint8_t local_role = HAL_PAN_ROLE_NONE;
> >>-static uint32_t record_id = 0;
> >>+char bridge[5] = "bnep\0";
> >This last line raises several questions. Firstly, C-strings have an
> >implicit nul-character at the end so no need to explicitly try to add
> >one there. You also don't need to have an explicit size between the
> >square brackets since this is automatically calculated if you do
> >initialization upon declaration. Why isn't this static? Why isn't it
> >const? Would a simple define make more sense instead of a dedicated
> >variable?
> 
>  I tried these but there are some warnings.
> 
> #define BNEP_BRIDGE   "bnep"
> static char bridge[] = "bnep";
> static char *bridge = "bnep";
> 
> ==10198== Warning: noted but unhandled ioctl 0x89a1 with no
> size/direction hints
> ==10198==    This could cause spurious value errors to appear.
> ==10198==    See README_MISSING_SYSCALL_OR_IOCTL for guidance on
> writing a proper wrapper.

Is this from valgrind? If so, then I think it's fine to ignore it as it
simply doesn't know the details of all ioctls. We get this kind of
stuff for Bluetooth specific ioctls too. I.e. go with whatever is the
simplest (probably the define).

Johan
