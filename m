Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Oct 2009 11:30:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] init and extra checking fixups
Message-ID: <20091002093005.GC13444@jh-x301>
References: <200909261237.58379.sgrubb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200909261237.58379.sgrubb@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Sep 26, 2009, Steve Grubb wrote:
> I was doing some code reviews of the 4.54 release and found a couple
> things that should be fixed up. This patch is looking at things that may not
> have been initialized or is doing value checks that are unnecessary.
> 
> In audio/avdtp.c, the avdtp_setconf_cmd function has an exit jump for failed.
> There are several calls to the goto that do not set err to something, meaning
> that the stack contents are what's used. I set err =0 in the beginning so that
> we no longer use the stack contents, but it seems like there should be some
> general error code that says we failed for an unspecified reason.
> 
> In audio/control.c, the function control_cb takes a variable cond and first
> thing it or's G_IO_IN with it and uses the result for a test in an if
> statement. I suspect it should be a '&' operator.
> 
> In audio/unix.c, the function a2dp_discovery_complete at line 659 has a
> variable ca2dp. There is a check at line 661 to see that its not NULL. It can
> never be NULL because its position in the unix_client structure will never
> let it be NULL. So, this check should be dropped.
> 
> In compat/hidd.c, there is a function do_connect with a variable, name. It
> could conceivably be uninitialized when used in a strcmp at line 473. 
> 
> In lib/sdp.c, the function sdp_get_lang_attr has a variable pCode that is
> being checked for non-NULL at line 2029. It gets its value from curr_data which
> has to be non-NULL to enter the loop. So, checking pCode does nothing. It
> should be dropped.
> 
> Same file, in the function sdp_service_attr_req there is a variable
> rsp_concat_buf. If the allocations for reqbuf or rspbuf fail, it goes to end
> where it will attempt to free rsp_concat_buf.data which is whatever the stack
> contents are. This same issue pops up again in the function,
> sdp_service_search_attr_req a little farther down.
> 
> NOT FIXED - In src/sdpd-service.c, the function create_ext_inquiry_response
> has a variable uuid that is used at line 223 in an equality test without
> having been initialized. No idea what the right code for that is.
> 
> In tools/hcitool.c, around line 687, handle could conceivably be used without
> being initialized. I set it to 0.
> 
> Signed-off-by: Steve Grubb <sgrubb@redhat.com>

I went ahead and split up this patch myself and also did the few necessary
fixups to it. The changes are now upstream.

Johan
