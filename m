Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 May 2012 20:31:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	chanyeol.park@samsung.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Fix avrcp unregister potential crash
Message-ID: <20120518173149.GA11135@x220.P-661HNU-F1>
References: <1337331254-30749-1-git-send-email-chanyeol.park@samsung.com>
 <1337331254-30749-2-git-send-email-chanyeol.park@samsung.com>
 <20120518114032.GB1375@x220.P-661HNU-F1>
 <CAMOw1v4bO_xYRyLReN81riFtmvUxqx_=5AC3p4D9W3yzkn2EWA@mail.gmail.com>
 <20120518150859.GA6384@x220.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20120518150859.GA6384@x220.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, May 18, 2012, Johan Hedberg wrote:
> On Fri, May 18, 2012, Lucas De Marchi wrote:
> > >> --- a/audio/avrcp.c
> > >> +++ b/audio/avrcp.c
> > >> @@ -1272,8 +1272,11 @@ void avrcp_unregister(const bdaddr_t *src)
> > >>
> > >>       servers = g_slist_remove(servers, server);
> > >>
> > >> -     remove_record_from_server(server->ct_record_id);
> > >> -     remove_record_from_server(server->tg_record_id);
> > >> +     if (server->ct_record_id)
> > >> +             remove_record_from_server(server->ct_record_id);
> > >> +
> > >> +     if (server->tg_record_id)
> > >> +             remove_record_from_server(server->tg_record_id);
> > >>
> > >>       avctp_unregister(&server->src);
> > >>       g_free(server);
> > >
> > > I don't think the commit message for this patch is truthful. If you look
> > > at the code the remove_record_from_server will return ENOENT if you pass
> > > it a non-existent handle. I.e. it will not crash. Please fix the commit
> > > message to reflect what exactly is being fixed (i.e. an unnecessary call
> > > to remove_record_from_server if there is no record handle).
> > 
> > Then I don't see a reason: just let remove_record_from_server() fail ?
> > 
> > Chan, what are you fixing here?
> 
> As discussed on IRC (and Chanyeol should really have explained this in
> the commit message) handle 0 is actually the SDP server's own "master"
> record. So it is plausible that weird behavior might occur if trying to
> remove it. Since this is a SDP server internal detail and it doesn't
> really make sense to remove it I'm thinking that
> remove_record_from_server should return EINVAL if passed a 0 value.

I already pushed a patch for this so no need to work on it anymore.

Johan
