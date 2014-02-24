Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Feb 2014 09:03:11 +0200
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv2 5/6] unit/avrcp: Add /TP/ICC/BV-01-I/CT test
Message-ID: <20140224070041.GC4133@aemeltch-MOBL1>
References: <1392996230-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1392996230-11789-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZKcpH-7QeYcFv3wV=sToyeeOBd19+4mTW2k8vzSfxaYVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZKcpH-7QeYcFv3wV=sToyeeOBd19+4mTW2k8vzSfxaYVA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, Feb 23, 2014 at 02:06:59PM +0200, Luiz Augusto von Dentz wrote:
> HI Andrei,
> 
> On Fri, Feb 21, 2014 at 5:23 PM, Andrei Emeltchenko
> <andrei.emeltchenko@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Test verifies that the Controller can collect information of Target
> > by UNIT INFO command.
> > ---
> >  unit/test-avrcp.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> > index f1c0f46..2cb28b1 100644
> > --- a/unit/test-avrcp.c
> > +++ b/unit/test-avrcp.c
> > @@ -242,6 +242,37 @@ static void test_dummy(gconstpointer data)
> >         destroy_context(context);
> >  }
> >
> > +static void execute_context(struct context *context)
> > +{
> > +       g_main_loop_run(context->main_loop);
> > +
> > +       if (context->source > 0)
> > +               g_source_remove(context->source);
> > +
> > +       avrcp_shutdown(context->session);
> > +
> > +       g_main_loop_unref(context->main_loop);
> > +
> > +       test_free(context->data);
> > +       g_free(context);
> > +}
> > +
> > +static void test_client(gconstpointer data)
> > +{
> > +       struct context *context = create_context(0x0100, data);
> > +       struct avctp *session = avrcp_get_avctp(context->session);
> > +       int ret = 0;
> > +
> > +       if (g_str_equal(context->data->test_name, "/TP/ICC/BV-01-I/CT"))
> > +               ret = avctp_send_unit_info_req(session, NULL, NULL);
> > +
> > +       DBG("ret = %d", ret);
> > +
> > +       g_assert(!ret);
> > +
> > +       execute_context(context);
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> >         g_test_init(&argc, &argv, NULL);
> > @@ -261,5 +292,11 @@ int main(int argc, char *argv[])
> >         define_test("/TP/CRC/BV-01-I", test_dummy, raw_pdu(0x00));
> >         define_test("/TP/CRC/BV-02-I", test_dummy, raw_pdu(0x00));
> >
> > +       /* Information collection for control tests */
> > +
> > +       define_test("/TP/ICC/BV-01-I/CT", test_client,
> > +                       raw_pdu(0x00, 0x11, 0x0e, 0x01, 0xf8, 0x30,
> > +                               0xff, 0xff, 0xff, 0xff, 0xff));
> > +
> >         return g_test_run();
> >  }
> > --
> > 1.8.3.2
> 
> There is no such test in the test spec, there is only TP/ICC/BV-01-I,
> perhaps you adding CT yourself just to be able to define the same test
> for the TG but in that case I think it is better to separate with
> different macros e.g. define_test_ct prefixing with "CT" to make
> better distinction and don't mess with test names otherwise we may
> confuse people looking at those tests.

Sorry don't get it. How we might confuse people with it? Anybody who
looked at least once to the spec wouldn't be confused, and others do not
care.

Anyway please propose any way I will follow example.

BTW: What is really confusing are names in pts-avrcp.txt. They are
almost completely different like for the case above:

"TC_TG_ICC_BV_01_I"

Best regards 
Andrei Emeltchenko 
