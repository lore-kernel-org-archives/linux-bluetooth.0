Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1245611096.15367.76.camel@violet>
References: <2d5a2c100906090617m167d3815pae998d06bdbd6646@mail.gmail.com>
	 <2d5a2c100906210708x1816e5d9hb9a80c82d76da6dd@mail.gmail.com>
	 <1245595707.15367.66.camel@violet>
	 <2d5a2c100906210930q394fcf77hcd2bf39c26ae74f8@mail.gmail.com>
	 <1245603529.15367.68.camel@violet>
	 <2d5a2c100906211047n31b9d4dajac290601c184380b@mail.gmail.com>
	 <1245611096.15367.76.camel@violet>
Date: Mon, 22 Jun 2009 18:49:53 -0300
Message-ID: <2d5a2c100906221449y6e37cb19x1bc27085bac318f4@mail.gmail.com>
Subject: Re: regression introduced on v2.6.30-rc1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 21, 2009 at 4:04 PM, Marcel Holtmann<marcel@holtmann.org> wrote:
> stupid specification. It is just bloody stupid that we have to cleanup
> someone else's stuff that we haven't initiated in the first place :(
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 374536e..864c3c4 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -466,6 +466,11 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
>
> а а а а а а а аskb_queue_purge(&d->tx_queue);
> а а а а а а а аrfcomm_dlc_unlink(d);
> +
> + а а а а а а а /* Specification demands to cleanup after remote
> + а а а а а а а а* initiated session when closing last DLC */
> + а а а а а а а if (list_empty(&s->dlcs))
> + а а а а а а а а а а а rfcomm_session_put(s);
> а а а а}


As your patch seems to trigger DISC 0 in both sides when the remote
stack cope with DM I would suggest introducing a timer_list to
rfcomm_session so we can give some time to remote stack to take down
dlci 0 clean it up otherwise.


@@ -244,6 +246,33 @@ static inline int rfcomm_check_security(struct
rfcomm_dlc *d)
 								auth_type);
 }

+static void rfcomm_session_timeout(unsigned long arg)
+{
+	struct rfcomm_session *s = (void *) arg;
+
+	BT_DBG("session %p state %ld", s, s->state);
+
+	set_bit(RFCOMM_TIMED_OUT, &s->flags);
+	rfcomm_session_put(s);
+	rfcomm_schedule(RFCOMM_SCHED_TIMEO);
+}
+
+static void rfcomm_session_set_timer(struct rfcomm_session *s, long timeout)
+{
+	BT_DBG("session %p state %ld timeout %ld", s, s->state, timeout);
+
+	if (!mod_timer(&s->timer, jiffies + timeout))
+		rfcomm_session_hold(s);
+}
+
+static void rfcomm_session_clear_timer(struct rfcomm_session *s)
+{
+	BT_DBG("session %p state %ld", s, s->state);
+
+	if (timer_pending(&s->timer) && del_timer(&s->timer))
+		rfcomm_session_put(s);
+}
+
 /* ---- RFCOMM DLCs ---- */
 static void rfcomm_dlc_timeout(unsigned long arg)
 {
@@ -320,6 +349,7 @@ static void rfcomm_dlc_link(struct rfcomm_session
*s, struct rfcomm_dlc *d)

 	rfcomm_session_hold(s);

+	rfcomm_session_clear_timer(s);
 	rfcomm_dlc_hold(d);
 	list_add(&d->list, &s->dlcs);
 	d->session = s;
@@ -335,6 +365,9 @@ static void rfcomm_dlc_unlink(struct rfcomm_dlc *d)
 	d->session = NULL;
 	rfcomm_dlc_put(d);

+	if (list_empty(&s->dlcs))
+		rfcomm_session_set_timer(s, RFCOMM_DISC_TIMEOUT);
+
 	rfcomm_session_put(s);
 }

@@ -454,6 +487,7 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 			rfcomm_schedule(RFCOMM_SCHED_AUTH);
 			break;
 		}
+
 		/* Fall through */

 	default:
@@ -567,6 +601,8 @@ static struct rfcomm_session
*rfcomm_session_add(struct socket *sock, int state)

 	BT_DBG("session %p sock %p", s, sock);

+	setup_timer(&s->timer, rfcomm_session_timeout, (unsigned long)s);
+
 	INIT_LIST_HEAD(&s->dlcs);
 	s->state = state;
 	s->sock  = sock;
@@ -639,6 +675,7 @@ static void rfcomm_session_close(struct
rfcomm_session *s, int err)
 		__rfcomm_dlc_close(d, err);
 	}

+	rfcomm_session_clear_timer(s);
 	rfcomm_session_put(s);
 }

@@ -1774,6 +1811,7 @@ static inline void rfcomm_process_dlcs(struct
rfcomm_session *s)
 				rfcomm_send_dm(s, d->dlci);
 			else
 				d->state = BT_CLOSED;
+
 			__rfcomm_dlc_close(d, ECONNREFUSED);
 			continue;
 		}
@@ -1879,6 +1917,11 @@ static inline void rfcomm_process_sessions(void)
 		struct rfcomm_session *s;
 		s = list_entry(p, struct rfcomm_session, list);

+		if (test_bit(RFCOMM_TIMED_OUT, &s->flags)) {
+			rfcomm_session_put(s);
+			continue;
+		}
+
 		if (s->state == BT_LISTEN) {
 			rfcomm_accept_connection(s);
 			continue;


-- 
Luiz Augusto von Dentz
Engenheiro de Computaчуo
