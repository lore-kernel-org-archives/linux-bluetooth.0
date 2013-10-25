Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Oct 2013 13:08:23 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Fix incorrect casts of addresses
Message-ID: <20131025100821.GD6113@aemeltch-MOBL1>
References: <1382691070-24358-1-git-send-email-jerzy.kasenberg@tieto.com>
 <20131025093227.GB6113@aemeltch-MOBL1>
 <CAHCYCozKG2K+QOvX_2eYSD96DGikc-v9dK1VNtX81tLdFzXvXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHCYCozKG2K+QOvX_2eYSD96DGikc-v9dK1VNtX81tLdFzXvXg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Fri, Oct 25, 2013 at 11:50:22AM +0200, Jerzy Kasenberg wrote:
> Hi Andrei,
> 
> On 25 October 2013 11:32, Andrei Emeltchenko
> <andrei.emeltchenko.news@gmail.com> wrote:
> > Hi Jerzy,
> >
> > On Fri, Oct 25, 2013 at 10:51:10AM +0200, Jerzy Kasenberg wrote:
> >> This fixes printing of addresses.
> >> If char is set to be signed (as it should) some addresses were
> >> printed with leading FFFFFF.
> >> ---
> >> This issue did not showed up before due to unsigned char for Android build
> >> on Qualcomm platform.
> >>
> >>  android/client/textconv.c |    4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/android/client/textconv.c b/android/client/textconv.c
> >> index 1188477..bcdf4d9 100644
> >> --- a/android/client/textconv.c
> >> +++ b/android/client/textconv.c
> >> @@ -137,7 +137,7 @@ int int2str_findstr(const char *str, const struct int2str m[])
> >>   */
> >>  char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf)
> >>  {
> >> -     const char *p = (const char *) bd_addr;
> >> +     const uint8_t *p = bd_addr->address;
> >>
> >>       snprintf(buf, MAX_ADDR_STR_LEN, "%02x:%02x:%02x:%02x:%02x:%02x",
> >>                                       p[0], p[1], p[2], p[3], p[4], p[5]);
> >
> > is this correct order btw?
> 
> Tool print same address for my mouse as I see printed on the mouse so
> I guess it's correct.

OK, those are addresses sent through HAL, they are in different format.

Best regards 
Andrei Emeltchenko 

> 
> >
> > Best regards
> > Andrei Emeltchenko
> >
> >> @@ -148,7 +148,7 @@ char *bt_bdaddr_t2str(const bt_bdaddr_t *bd_addr, char *buf)
> >>  /* converts string to bt_bdaddr_t */
> >>  void str2bt_bdaddr_t(const char *str, bt_bdaddr_t *bd_addr)
> >>  {
> >> -     char *p = (char *) bd_addr;
> >> +     uint8_t *p = bd_addr->address;
> >>
> >>       sscanf(str, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
> >>                              &p[0], &p[1], &p[2], &p[3], &p[4], &p[5]);
> >> --
> >> 1.7.9.5
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Best regards
> Jerzy
