Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1311010504-15060-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1311010504-15060-1-git-send-email-claudio.takahasi@openbossa.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
Date: Tue, 19 Jul 2011 11:34:43 -0300
Message-ID: <CALJ2SBLju51yhOuK+nMrXBoyLs23SCdD+SN7kup0f+kzvEmcqQ@mail.gmail.com>
Subject: Re: [RFC BlueZ] Proximity API simplification
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Jul 18, 2011 at 2:35 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Delegates the Immediate Alert Level control to the caller(client).
> Immediate Alert Service is shared between Path Loss and Find Me.
>
> Cons: distributed actions may impact qualification. Client needs to
> control when to write the Immediate Alert based on the received
> SignalLevel received.
> ---
>
>  I'd like to collect feedbacks before proceeding with this change.
>  Does it look more clear than the previous API version?
>
>  The ideia is to move to the kernel the RSSI value polling. The
>  userspace will receive notifications when one of the SignalLevel
>  threshold is triggered: "good", "regular", "week".

How about simplify more and have just two alert levels? Is there any
reason to have three? It could simplify the RSSI Monitor in the
kernel.

Regards,

Anderson Briglia

>
>  Regards,
>  Claudio
>
>  doc/proximity-api.txt |   36 ++++++------------------------------
>  1 files changed, 6 insertions(+), 30 deletions(-)
>
> diff --git a/doc/proximity-api.txt b/doc/proximity-api.txt
> index ed78fb5..cf64bbf 100644
> --- a/doc/proximity-api.txt
> +++ b/doc/proximity-api.txt
> @@ -30,29 +30,11 @@ Signals             PropertyChanged(string name, variant value)
>                        property.
>
>  Properties
> -               uint8 PathLoss[readonly]
>
> -                       If Tx Power Service is available, this property value
> -                       will be reported on regular intervals when the peer is
> -                       connected. Range: 0 - 100. The number is a relative
> -                       value to represent inaccurately the signal strength,
> -                       where 0 represents out of range and 100 close to the
> -                       reporter.
> +               string SignalLevel[readonly]
>
> -               string Threshold [readwrite]
> -
> -                       Persistent property. Trigger for immediate alert.
> -                       Values: "low", "medium", "high". Enabled only if Tx
> -                       Power and Immediate Alert services are available in
> -                       the reporter. Controls when the immediate alert is
> -                       triggered in the reporter.
> -
> -               boolean ThresholdAlert[readonly]
> -
> -                       Alert indicating that threshold has been reached or the
> -                       path loss returned to a value below the threshold. It is
> -                       up to the implementation catch this property value and
> -                       emit a sound in the proximity monitor.
> +                       Alert indicating that a threshold has been reached.
> +                       Possible values: "unknown", "good", "regular", "weak"
>
>                string LinkLossAlertLevel [readwrite]
>
> @@ -60,16 +42,10 @@ Properties
>                        proximity reporter for link loss scenario. Values:
>                        "none", "mild", "high".
>
> -               string PathLossAlertLevel [readwrite]
> -
> -                       Persistent property. Alert level for path loss scenario.
> -                       It's a LOCAL property value written in the Alert Level of
> -                       the Immediate Alert service when the threshold alert is
> -                       triggered. Values: "none", "mild", "high".
> -
> -               string FindMeAlertLevel [readwrite]
> +               string ImmediateAlertLevel [readwrite]
>
> -                       Alert level to be written in the Find Me Target.
> +                       Alert level to be written in the Immediate Alert Level.
> +                       Property shared between Path Loss and Find Me.
>                        Values: "none", "mild", "high". Default value is
>                        "none". Applications can disable the alert setting
>                        the value to "none". If the "Target" is not found,
> --
> 1.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
INdT - Instituto Nokia de tecnologia
+55 92 2126 1122
+55 92 8423 3183
