Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: roel <12o3l@tiscali.nl>
In-Reply-To: <46F6E502.9000101@tiscali.nl>
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<20070923030105.GH2475@hacking>  <46F6E502.9000101@tiscali.nl>
Date: Mon, 24 Sep 2007 09:09:11 +0200
Message-Id: <1190617751.5133.88.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: WANG Cong <xiyou.wangcong@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, maxk@qualcomm.com,
        linux-kernel@vger.kernel.org, bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [-mm Patch] net/bluetooth/hidp/core.c: Make
	hidp_setup_input()	return int
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

> > This patch does the following things:
> > 
> > - Make hidp_setup_input() return int to indicate errors.
> > - Check its return value to handle errors.
> > 
> > Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
> > 
> > ---
> >  net/bluetooth/hidp/core.c |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > Index: linux-2.6.23-rc6-mm1/net/bluetooth/hidp/core.c
> > ===================================================================
> > --- linux-2.6.23-rc6-mm1.orig/net/bluetooth/hidp/core.c
> > +++ linux-2.6.23-rc6-mm1/net/bluetooth/hidp/core.c
> > @@ -625,7 +625,7 @@ static struct device *hidp_get_device(st
> >  	return conn ? &conn->dev : NULL;
> >  }
> >  
> > -static inline void hidp_setup_input(struct hidp_session *session, struct hidp_connadd_req *req)
> > +static inline int hidp_setup_input(struct hidp_session *session, struct hidp_connadd_req *req)
> >  {
> >  	struct input_dev *input = session->input;
> >  	int i;
> > @@ -669,7 +669,7 @@ static inline void hidp_setup_input(stru
> >  
> >  	input->event = hidp_input_event;
> >  
> > -	input_register_device(input);
> > +	return input_register_device(input);
> >  }
> >  
> >  static int hidp_open(struct hid_device *hid)
> > @@ -823,7 +823,8 @@ int hidp_add_connection(struct hidp_conn
> >  	session->idle_to = req->idle_to;
> >  
> >  	if (session->input)
> > -		hidp_setup_input(session, req);
> > +		if ((err = (hidp_setup_input(session, req))))
> > +			goto failed;
> 
> This is confusing, why not just do
> 
> 	if (session->input) {
> 		err = hidp_setup_input(session, req);
> 		if (err)
> 			goto failed;
> 	}

lets use "if (err < 0)" and I am okay with that patch.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
