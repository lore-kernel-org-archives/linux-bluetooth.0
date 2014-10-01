Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	'Bharat Panda' <bharat.panda@samsung.com>
Subject: Re: [PATCH] obexd/src/main: Fix memory leak on obex server
Date: Wed, 01 Oct 2014 15:22:29 +0200
Message-ID: <2580394.BL666j3vo2@uw000953>
In-Reply-To: <000e01cfdd66$18e1fd20$4aa5f760$@samsung.com>
References: <1412145103-4824-1-git-send-email-gowtham.ab@samsung.com> <5138547.7BEzpM8uY4@uw000953> <000e01cfdd66$18e1fd20$4aa5f760$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Wednesday 01 of October 2014 16:24:27 Gowtham Anandha Babu wrote:
> Hi Szymon,
> 
> > -----Original Message-----
> > From: Szymon Janc [mailto:szymon.janc@tieto.com]
> > Sent: Wednesday, October 01, 2014 2:31 PM
> > To: Gowtham Anandha Babu
> > Cc: linux-bluetooth@vger.kernel.org; 'Dmitry Kasatkin'; 'Bharat Panda'
> > Subject: Re: [PATCH] obexd/src/main: Fix memory leak on obex server
> > 
> > Hi Gowtham,
> > 
> > On Wednesday 01 of October 2014 14:21:22 Gowtham Anandha Babu wrote:
> > > Hi Szymon,
> > >
> > > > -----Original Message-----
> > > > From: Szymon Janc [mailto:szymon.janc@tieto.com]
> > > > Sent: Wednesday, October 01, 2014 12:28 PM
> > > > To: Gowtham Anandha Babu
> > > > Cc: linux-bluetooth@vger.kernel.org; d.kasatkin@samsung.com;
> > > > bharat.panda@samsung.com; cpgs@samsung.com
> > > > Subject: Re: [PATCH] obexd/src/main: Fix memory leak on obex server
> > > >
> > > > Hi Gowtham,
> > > >
> > > >  On Wednesday 01 of October 2014 12:01:43 Gowtham Anandha Babu
> > wrote:
> > > > > Freeing the variables at appropriate place.
> > > > > ---
> > > > >  obexd/src/main.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/obexd/src/main.c b/obexd/src/main.c index
> > > > > 80645f8..7a1ab98 100644
> > > > > --- a/obexd/src/main.c
> > > > > +++ b/obexd/src/main.c
> > > > > @@ -293,8 +293,9 @@ int main(int argc, char *argv[])
> > > > >  		char *old_root = option_root, *home = getenv("HOME");
> > > > >  		if (home) {
> > > > >  			option_root = g_strdup_printf("%s/%s", home,
> > > > old_root);
> > > > > -			g_free(old_root);
> > > > > +			g_free(home);
> > > > >  		}
> > > > > +		g_free(old_root);
> > > > >  	}
> > > > >
> > > > >  	if (option_capability == NULL)
> > > > >
> > > >
> > > > This patch is incorrect in multiple ways:
> > > > - freeing old_root without altering option_root would result in use-after-
> > free
> > > >   few lines later in root_folder_setup() or (if program didn't crash already)
> > > >   double free on exit.
> > > > - freeing home pointer would result in crash or undefined behavior:
> > > >   from getenv manual: "As typically implemented, getenv() returns a
> > > > pointer to
> > > >   a string within the environment list.  The caller must take care not to
> > > >   modify this string, since that would change the environment of the
> > process.
> > > >   ...The string pointed to by the return value of getenv() may be statically
> > > >   allocated,"
> > > >
> > > > But I agree that original code is a bit confusing. Maybe something
> > > > like this would make it more readable?
> > > >
> > > > --- a/obexd/src/main.c
> > > > +++ b/obexd/src/main.c
> > > > @@ -290,8 +290,9 @@ int main(int argc, char *argv[])
> > > >         }
> > > >
> > > >         if (option_root[0] != '/') {
> > > > -               char *old_root = option_root, *home = getenv("HOME");
> > > > +               const char *home = getenv("HOME");
> > > >                 if (home) {
> > > > +                       char *old_root = option_root;
> > > >                         option_root = g_strdup_printf("%s/%s", home, old_root);
> > > >                         g_free(old_root);
> > > >                 }
> > > >
> > > >
> > > > --
> > > > Best regards,
> > > > Szymon Janc
> > >
> > > I agree with you.
> > > But why can't it be like this
> > >
> > > 	if (option_root[0] != '/') {
> > > 		const char *home = getenv("HOME");
> > > 		if (home) {
> > > 			option_root = g_strdup_printf("%s/%s", home,
> > option_root);
> > > 		}
> > > 	}
> > > ---
> > > (checked, it's not crashing)
> > 
> > 
> > In that case you are leaking option_root. That is why temporary old_root is
> > needed so that original option_root can be freed.
> > 
> > --
> > Best regards,
> > Szymon Janc
> 
> Sorry If I am wrong, at the end option_root was freed after g_mail_loop_unref(main_loop). Is that enough ? 
> Or Do we need to free that intermediate option_root inside g_strdup_printf() ?

Memory pointed by old option_root needs to be freed since pointer is
overwritten. I suggest exploring valgrind for tracking memory leaks
(see HACKING for guideline).

> One more clarification:
> 
> static gboolean parse_debug(const char *key, const char *value,
> 				gpointer user_data, GError **error)
> {
> 	if (value)
> 		option_debug = g_strdup(value);
> 	else
> 		option_debug = g_strdup("*");
> 
> 	return TRUE;
> }
> 
> 
> In the above function, option_debug needs be freed right? As Like below:
> 
> static gboolean parse_debug(const char *key, const char *value,
> 				gpointer user_data, GError **error)
> {
> 	g_free(option_debug);
> 	if (value)
> 		option_debug = g_strdup(value);
> 	else
> 		option_debug = g_strdup("*");
> 
> 	return TRUE;
> }

There is no need to free that since option_debug is initially NULL.

-- 
Best regards, 
Szymon Janc
