Return-Path: <hadess@hadess.net>
Message-ID: <1504622674.6911.21.camel@hadess.net>
Subject: Re: [PATCH] tools/csr_usb: Fix compilation failure
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 05 Sep 2017 16:44:34 +0200
In-Reply-To: <27E0FF70-D31E-4CD2-82C2-75660B1C14BF@holtmann.org>
References: <20170905083534.19184-1-hadess@hadess.net>
	 <1504601609.5928.3.camel@hadess.net>
	 <27E0FF70-D31E-4CD2-82C2-75660B1C14BF@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2017-09-05 at 15:15 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > GCC's "format-nonliteral" security check is enabled as an error
> > > in
> > > recent versions of Fedora. Given the reduced scope of use, mark
> > > the
> > > error as ignorable through pragma.
> > > 
> > > tools/csr_usb.c: In function 'read_value':
> > > tools/csr_usb.c:82:2: error: format not a string literal,
> > > argument
> > > types not checked [-Werror=format-nonliteral]
> > >  n = fscanf(file, format, &value);
> > >  ^
> > 
> > I also ran into this, which looks suspicious:
> > obexd/plugins/bluetooth.c: In function 'register_profile':
> > obexd/plugins/bluetooth.c:310:7: error: format not a string
> > literal, argument types not checked [-Werror=format-nonliteral]
> >       profile->driver->port);
> >       ^~~~~~~
> > obexd/plugins/bluetooth.c:314:7: error: format not a string
> > literal, argument types not checked [-Werror=format-nonliteral]
> >       profile->driver->name);
> >       ^~~~~~~
> 
> we would have to change the code on how to build the XML record
> information. However here it is the same issue with the compiler not
> getting that the actual value used is const. So it seems this warning
> has no logic on traversing any levels down.
> 
> I mean for example HFP_HF_RECORD is a static const string. It just
> gets handed through an interim const char * pointer variable before
> used as format descriptor. Frankly gcc is stupid here.

The problem isn't just the string being const or not, it's also the
compiler having no way to know the possible values for that string.

Maybe the string can only be a couple of hardcoded values, but that's
already stretching the limits of what analysis the compiler can do.

For example, how is it to know that when the port is 0, there's this
many arguments to the printf()-style function in the record string, and
this many when port is non-0?

If this is only used in the synce and pcsuite plugins, I'd do the
printf() in the plugins, instead of indirectly accessing the ->record
string. Would that be OK?
