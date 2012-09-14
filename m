Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Sep 2012 09:40:58 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Subject: Re: [PATCHv4 02/17] Bluetooth: A2MP: Create amp_mgr global list
Message-ID: <20120914064051.GA7483@aemeltch-MOBL1>
References: <alpine.DEB.2.02.1209111121550.3754@mathewm-linux>
 <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347437192-24694-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <alpine.DEB.2.02.1209130802210.19321@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1209130802210.19321@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Sep 13, 2012 at 08:02:58AM -0700, Mat Martineau wrote:
...

> >@@ -550,6 +558,10 @@ static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
> >
> >	conn->hcon->amp_mgr = mgr;
> >
> >+	mutex_lock(&amp_mgr_list_lock);
> >+	list_add(&mgr->list, &amp_mgr_list);
> >+	mutex_unlock(&amp_mgr_list_lock);
> >+
> >	kref_init(&mgr->kref);
> 
> Should the reference count be initialized before adding to the list?

will change this.

Best regards 
Andrei Emeltchenko 

