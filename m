Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC 15/16] android: Implement basic HAL server
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130930082507.GF10262@aemeltch-MOBL1>
Date: Mon, 30 Sep 2013 10:33:54 +0200
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <9C20AE4B-57C8-48A8-AE2B-80CE7E334C7D@holtmann.org>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1380291161-10232-16-git-send-email-Andrei.Emeltchenko.news@gmail.com> <CAJdJm_PMy6pb-NnCc5fKc11ATUwKbSd71HMAWueWkxP_x4Ym=A@mail.gmail.com> <20130930082507.GF10262@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>>> +static gboolean io_session_event(GIOChannel *chan, GIOCondition cond,
>>> +                                                               gpointer data)
>>> +{
>>> +       struct hal_msg_hdr hdr;
>>> +       struct hal_msg_rsp rsp;
>>> +       uint8_t *buf;
>>> +       int sock, len, size;
>>> +       uint8_t status;
>>> +
>>> +       if (cond & G_IO_NVAL)
>>> +               return FALSE;
>>> +
>>> +       sock = g_io_channel_unix_get_fd(chan);
>>> +
>>> +       if (cond & (G_IO_HUP | G_IO_ERR)) {
>>> +               error("%s: error condition %d", __func__, cond);
>>> +               /* TODO: handle */
>>> +               return FALSE;
>>> +       }
>>> +
>>> +       len = recv(sock, &hdr, sizeof(hdr), MSG_PEEK);
>>> +       if (len != sizeof(hdr)) {
>>> +               /* TODO: handle */
>>> +               return FALSE;
>>> +       }
>>> +
>>> +       size = sizeof(hdr) + hdr.len;
>>> +       buf = malloc(size);
>>> +       if (!buf)
>>> +               return TRUE;
>>> +
>>> +       len = recv(sock, buf, size, 0);
>>> +       if (len != size) {
>>> +               /* TODO: handle */
>>> +               free(buf);
>>> +               return FALSE;
>>> +       }
>>> +
>>> +       status = process_hal_msg(buf, len);
>>> +
>>> +       free(buf);
>>> +
>>> +       memcpy(&rsp, &hdr, sizeof(hdr));
>>> +       rsp.hdr.len = sizeof(uint8_t);
>>> +       rsp.status = status;
>> 
>> You are not using "rsp" on this function (and not TODO comment explaining why).
> 
> will fix this.
> 
>> 
>>> +       /* Since daemon would be run also on host we have to grant perms */
>>> +       chmod(sock_path, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH |
>>> +                                                               S_IWOTH);
>> 
>> If it is really necessary to have a world writable socket, better
>> explain in detail on the comment.
> 
> the problem here is that we need to run this on a host and on Android
> where HAL is running under user bluetooth, this has to be changed to use
> ifdef logic.

and why are we not starting the daemon as user bluetooth with proper capabilities.

Regards

Marcel

