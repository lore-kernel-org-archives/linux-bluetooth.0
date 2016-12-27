Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1482369439-57601-1-git-send-email-juha.kuikka@synapse.com>
References: <1482369439-57601-1-git-send-email-juha.kuikka@synapse.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 Dec 2016 15:11:01 +0200
Message-ID: <CABBYNZK5-H5Khfjd9me3rXNbG6j-5kE6-EJ1Hd91hrwKA3wrMw@mail.gmail.com>
Subject: Re: [PATCH] Remove deprecated UHID_FEATURE API
To: Juha Kuikka <juha.kuikka@synapse.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Juha,

On Thu, Dec 22, 2016 at 3:17 AM, Juha Kuikka <juha.kuikka@synapse.com> wrote:
> I believe I have identified an issue with the HID-over-GATT (HoG) where,
> through hidraw, the HIDIOCGFEATURE does not work correctly.
>
> The symptom is that the ioctl call returns immediately with bogus data,
> before the Read Request to the peripheral has been completed.
>
> I believe the issue is caused by the hog-lib.c registering a handler for
> both UHID_FEATURE and UHID_GET_REPORT events, which in the uhid header
> file turn out to be the same enum.
>
> This causes the get_report() to get called first, it issues the Read
> Request and waits for it's completion. After this the get_feature() is
> immediately called with the same uhid message, which sends the
> UHID_FEATURE_ANSWER in to the kernel with stale data, which then gets
> returned to the hidraw caller.
>
> I have fixed this by removing the get_feature() as it is unnecessary
> anyway. See attached patch.
>
> I have tested with against both old and new uhid API (kernels 3.8 and
> 4.4).
> ---
>  profiles/input/hog-lib.c | 33 ---------------------------------
>  1 file changed, 33 deletions(-)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index e376c2b..75c6078 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -704,38 +704,6 @@ static void forward_report(struct uhid_event *ev, void *user_data)
>                                                 data, size, NULL, NULL);
>  }
>
> -static void get_feature(struct uhid_event *ev, void *user_data)
> -{
> -       struct bt_hog *hog = user_data;
> -       struct report *report;
> -       struct uhid_event rsp;
> -       int err;
> -
> -       memset(&rsp, 0, sizeof(rsp));
> -       rsp.type = UHID_FEATURE_ANSWER;
> -       rsp.u.feature_answer.id = ev->u.feature.id;
> -
> -       report = find_report_by_rtype(hog, ev->u.feature.rtype,
> -                                                       ev->u.feature.rnum);
> -       if (!report) {
> -               rsp.u.feature_answer.err = ENOTSUP;
> -               goto done;
> -       }
> -
> -       if (!report->value) {
> -               rsp.u.feature_answer.err = EIO;
> -               goto done;
> -       }
> -
> -       rsp.u.feature_answer.size = report->len;
> -       memcpy(rsp.u.feature_answer.data, report->value, report->len);
> -
> -done:
> -       err = bt_uhid_send(hog->uhid, &rsp);
> -       if (err < 0)
> -               error("bt_uhid_send: %s", strerror(-err));
> -}
> -
>  static void set_report_cb(guint8 status, const guint8 *pdu,
>                                         guint16 plen, gpointer user_data)
>  {
> @@ -1034,7 +1002,6 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>         }
>
>         bt_uhid_register(hog->uhid, UHID_OUTPUT, forward_report, hog);
> -       bt_uhid_register(hog->uhid, UHID_FEATURE, get_feature, hog);
>         bt_uhid_register(hog->uhid, UHID_GET_REPORT, get_report, hog);
>         bt_uhid_register(hog->uhid, UHID_SET_REPORT, set_report, hog);
>
> --
> 1.9.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
