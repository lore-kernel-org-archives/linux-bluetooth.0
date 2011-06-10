Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTikb5hQAP-v=JbQa6j5L71Ki0kZoPA@mail.gmail.com>
References: <BANLkTikb5hQAP-v=JbQa6j5L71Ki0kZoPA@mail.gmail.com>
Date: Fri, 10 Jun 2011 18:39:23 -0300
Message-ID: <BANLkTik3-DZLBXyd_VGvGUDHbfJDnK420w@mail.gmail.com>
Subject: Re: GAP Discovery and Connection establishment for LE
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Jun 10, 2011 at 6:04 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi,
>
> I would like to discuss the implementation of the GAP discovery and
> connection establishment for LE. I will focus only on the Central
> role, which is the role we are actively working on at the moment. Also
> I'm only talking about the new "mgmt" API.
>
> Most of the discussed implementation is not yet upstream (they are on
> our "developer" trees on gitorious.org and infradead.org), but we are
> in the process of upstreaming it.
>
> Device Discovery:
> For dual mode (BR/EDR/LE) adapters, discovery is interleaved between
> BR/EDR and LE. This procedure is documented on Core spec, Vol. 3 [Part
> C], Section 13.2.1. For single mode adapters (although we have no
> working single mode adapter), LE only discovery is used, as described
> on Vol. 3 [Part C], Section 9.2.6. Note that only "General Discovery"
> is supported. We don't support Limited Discovery.
>
> Name discovery: not supported (both BR/EDR and LE)
>
> Connection establishment (over LE):
> "Direct Connection Establishment" procedure is followed, with these parameters:
>
> Scan interval: 2.5ms
> Scan window: 2.5ms
> Conn_Interval_Min: 5ms
> Conn_Interval_Max: 160ms
> Supervision timeout: 62.5ms (this is incorrect, it shall be larger
> than Conn_Interval_Max)
>
> Unsupported features
> ==================
>
> Now that the Thermometer GATT profile has been approved, anyone can
> take a look at the "Connection Establishment" section of
> https://www.bluetooth.org/docman/handlers/downloaddoc.ashx?doc_id=238687
> and notice the following:
>
> "The Collector should use the GAP Limited Discovery Procedure to
> discover a Thermometer."
>
> We currently do not support limited discovery.

LE limited discovery concept is different from BR. LE only sets the AD
Flags: Limited bit
The last patch series sent from Andre Guedes implementing interleaved
discovery doesn't introduce any restriction. The userspace needs to
extract the AD Flags from the EIR field only.

>
> "A Collector may use one of the following GAP connection procedures
> based on its connectivity requirements: [...]"
>
> We support only the Direct Connection Establishment Procedure.
>
> "The Collector should use the recommended scan interval and scan
> window values shown in Table 5.2. [...]"
>
> Our scan interval/window values are very different from the
> recommended ones (too small). I think this should be fixed.
>
> "For the first 30 seconds [...], the Collector should use the first
> scan window / scan interval pair to
> attempt fast connection. However, if a connection is not established
> within that time, the
> Collector should switch to one of the other scan window / scan
> interval options as
> defined below to reduce power consumption."
>
> We only attempt the connection once, using a fixed set of parameters.
> Maybe this needs to be changed to follow the recommendations above.
> Note that there are two "reduced power" configurations.
>
> "The Collector shall start encryption after each connection creation
> to verify the status of
> the bond. [...]"
>
> We don't require encryption, it is optional (by setting the security
> level to medium or high).
>
> "When a connection is terminated due to link loss, a Collector should
> attempt to reconnect to the Thermometer"
>
> We don't support automatic reconnection (yet).
>
> "The Collector may perform the GAP Terminate Connection procedure if
> the connection is idle for more than 5 seconds."
>
> We don't have such timer (is it specific to the Thermometer profile?)

Probably. Acceptable, but it doesn't help too much, it should be a
recommendation for thermometers instead of collectors. In the common
scenarios the thermometer has more power consumption constraints than
the collector.

>
> "To avoid very long service discovery and encryption times, the
> Collector should use the connection intervals defined in Table 5.3 in
> the connection request."
>
> We use fixed connection interval values during the entire connection.
>
> "This fast connection interval should be maintained as long as low latency is
> required. After that, it should switch to the preferred connection
> parameters as decided
> by the Thermometer using the GAP Connection Parameter Update procedure."
>
> We seem to support connection parameter update requests.

BlueZ supports slave side only. We need to refresh the discussion that
Ville started last year about connection parameters.
IMO we need to control the parameters based on profiles, if a
device(remote) supports multiple profiles we will need some logic to
infer the suitable settings.
Remember that connection parameters can also be informed in the
advertising data.

BR,
Claudio.
>
> Comments are welcome!
>
> Best Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
