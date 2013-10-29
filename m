Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Oct 2013 14:18:17 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 0/9] Improve logging for Android
Message-ID: <20131029121811.GE27517@aemeltch-MOBL1>
References: <1382957047-31775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383042118-21205-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAHCYCoz4tSeimwrwVNENWsGf-ZDq9Huq9jB9dOgwccrPiF8Fow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHCYCoz4tSeimwrwVNENWsGf-ZDq9Huq9jB9dOgwccrPiF8Fow@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Tue, Oct 29, 2013 at 12:43:32PM +0100, Jerzy Kasenberg wrote:
> Hi Andrei,
> 
> On 29 October 2013 11:21, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Changes:
> >         *v2: Added thread-safe helpers for printing properties, bdaddr, etc
> >         after comments that simple printing is not thread-safe. The idea is to
> >         use TLS (thread local storage) like bionic is doing for strerror for
> 
> Implementation of strerror in bionic and what is proposed here is
> thread safe but not
> useful if one wants to use one print to for two addresses or two
> properties (one buffer
> in one thread for two strings).

Then just print 2 times.

> In my opinion there should be safe functions that explicitly get
> string buffer as
> argument. For address and uuid they already exist, property printing
> was used in haltest
> only in one place and moving buffer form btproperty2str to function
> that calls it
> makes sense to me.

Then every function calling need to define a buffer and for property the
buffer is not small.

For example current code

...
static int set_adapter_property(const bt_property_t *property)
{
	char buf[sizeof(struct hal_cmd_set_adapter_prop) + property->len];
	struct hal_cmd_set_adapter_prop *cmd = (void *) buf;

	DBG("prop: %s", btproperty2str(property));
...

would need to define 4K buffer !!!, the same for many other functions.

> 
> If there is need for shortcut as for code lines that could be removed
> in compilation,
> wrapper function with pthread stuff can still be used (provided that
> there is no same
> type conversion call used in one print)
> 
> BTW strerror() works fine when called with value in range 0..131.
> But when you call it with higher number there will be a problem
> printf("%s\n%s\n\%s\n%s\n", strerror(1), strerror(2), strerror(132),
> strerror(133));
> prints:
> Operation not permitted
> No such file or directory
> Unknown error 133
> Unknown error 133

Yes, just print 2 times :)

Best regards 
Andrei Emeltchenko 

