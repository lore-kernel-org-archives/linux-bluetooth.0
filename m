Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872E34DCE3
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 04:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778645393; cv=pass; b=bvsCyD2brbKy3gfZaH4e91/aKypLe1YXLCJBWhXnsWJW/45TBThuj6oAHPAzbSdYs8UpLcE1j4Fbaor6BC2yP0xaIFtBKxKthxLF+Lgsj1URrILKJBRxDLwZsgYRLRCRaNfxUkbHnniiuUWLoNgsCelfahqtz0A0xNyd4S/EGPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778645393; c=relaxed/simple;
	bh=CXfpIbswTF3KaZpa+mYV3zgN/pIUY9iof0iEUf2hruU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DheaRY7/YZ3BD0FtbiswrEszK7wzqEko0f3M2GKvZ9GFfpU4OsRZXEObX+z4iE+d18OMfCXf5NgUWf+Ib633fVuccdnbxoqocwTi/b8Q/jimjP9SgneD0zlDL87s5kmW/HQYe2p0gv25shhG0x32yKL++FwyCa8oOZnk8Iz7T5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQpEKh+I; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQpEKh+I"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bb91b426e40so1045954666b.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 21:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778645390; cv=none;
        d=google.com; s=arc-20240605;
        b=lAA/0ZBQ7axcqHSuGirc0O8Jw+AgvgOiZH3OoOIh4UJzPLwBhxS6NGaXYfLa8T3x/J
         WFHfgFj55g81Z3Z4mKgL07JWQ/TXz5TngMvgyZujWdjGDA3h6xPC3tK6MM2i3JpGkcK8
         8ie2RS5in+K6J68m077Coqh5FMRlyFT68EIctxL0vml7gHbrrX1A1rOpJ3K4FRCgwS+P
         vuFktf9hcEJPUBzCRHbcfhn/txe9IKdvdOlsebpGVSuJphwJbZcrv2AdORxc8niNEFn/
         8jM6hKxH8tT/fJD1luPZXFrRncAoJsoRrNZ/SYYTOWylFYpzpB6aE/W+h+ja72WKHPRq
         PSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=R9e19VyOx1FjlmhObF3bHTyzARABrGIQZIiL7d6ZRwk=;
        fh=YyMYjAqMpx1OKeD/WNj8lTCXMfxtOx+0oOkwC9HqJuI=;
        b=BdTWznNldMeNbXJloz5ZtljdHkBpcoA4unlMXNFdnWnIh9LdXB5sOazdTNRAJQHiOJ
         HUZVC+h++FRqXBvED0Mvpa1ItPIvS7PUMORMY55aX9o+ewnZi0WOjR05B9i3+bYtM43+
         /U88N9mRfWfVR/hYna9iTEvQk6noD9kooF6AsfaGpJ84pIlQxh1Q3zsqD7Fy0vMSKEzO
         BFmmfkJ3rs2fwVTdkfgw5rA1xgocqa2rtUJm/iwXDdr3lXSQJQjG1sqB/l8xUJKD07yV
         70iFaxJy83tcDdKAlDvTtxzDuctNwzO3XYM4DMMVT9uf7JmrHY9Z1GgaLKNyd82jNtSu
         zGgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778645390; x=1779250190; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9e19VyOx1FjlmhObF3bHTyzARABrGIQZIiL7d6ZRwk=;
        b=dQpEKh+IGe4mb6vGexNiDmlqx6bm4WK+B2JF0cLzVQ28I6ACLrgb/aQPy2lsgTN94X
         kEnIU+FVQUuJAEmmmPJhjx0CNWm7q+W/s6NFGpQH8TcrRE91Lgy1jHhP6DuSLGPIORg2
         yhRA5mqmtjcX9xoN4onZAjxIWE46ckqvW3e+ywtH/LEGJpSAkNbM/SwVPybCzMzljCPI
         tQwN1i43HYqi44hLWAClJnJ/ocPvfvRfAQc61a8vORcwaSVe9F/BophGN4KEuJDzHe1Z
         O+ioau6pHRgBcsTWflHw3ZFnJQFBWstYgExZI2C9FDG9aB5/PgDo8kn9q/i+aS67XxVS
         KazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778645390; x=1779250190;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9e19VyOx1FjlmhObF3bHTyzARABrGIQZIiL7d6ZRwk=;
        b=pheSMSWAkwWUy7uaUB4EDsNSoTrY9y1uqvevzpHxkMOWsZZZSxyrthG6KhIGKyFvfR
         FYXnEmdhfBC/ccLOP2WNZxdypZaHtsmBqKs6w3lppjfrb9jF3GpYgE8oMv4QA67rEqKJ
         twUl+FpoI3G8q+xKlRZaXeVugniUUJ6+qaRnCqN36WAFHyo3n5T5qsYDJYrUnV3obUkQ
         V6XDW57zCmLUaQIdQQWL3WSxfHVOC5q8aB7yo8+PVgjUmZdxC4ljMu4s0Lx072VyD3UI
         9devYB51yKULluhtkJS0ml4ZnETE62ErSLbCddyqnJ2qeOfvu9+HYFM0ajblqXYc7+uP
         5MCA==
X-Gm-Message-State: AOJu0YwR8/qxz2cinoxGpDp5H9Sm3MjHQpId9sGZUo/QTPSJ+vtL+bCY
	AZ0tMUyfJhelSYiIP04u7hwGGA73LKMpqxSQ7z9yE4oOta4XXo/Oi5PQzqjFptVnO1HvWXS+dQe
	k//CldRycX5FSCRLAhHUU6IdZLTft9WocQed65/lY+ZchhSPLPlgrKZGr
X-Gm-Gg: Acq92OElxfJpLsx1x6Ud9C0DDm9IRUQD+8IhE90gMIzMh5Hj6+89YZqjXsU+JDiSEIX
	0xz1PUcddXBxkDdusFdWRSJVamqqN6u7kvLE3OriwTWk+8v/6uDNFva/kfKwfGdZDvjNsQodERU
	akFRQRuuxZgweSZ4n7p6632o0NDQDnbWHyZ0YCFdDSEZhks4DFuXEI688u3AP+MKqBY6vL8p3rL
	BAdRPwy85EHsT9qQH53j0sJ6fxS9aaRSQB7s3noDuehRd0GCx9WC41bcw+hk77aQ9f/ZRY/fs2n
	3jn1Fq1sHrMS2z/sQ3nBHR0rbe3N3bTOwgL+OD7IsukbGOam
X-Received: by 2002:a17:907:60ce:b0:bd3:94f4:6db0 with SMTP id
 a640c23a62f3a-bd3dadbe52emr65969166b.0.1778645389652; Tue, 12 May 2026
 21:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415073940.739683-1-apusaka@google.com>
In-Reply-To: <20260415073940.739683-1-apusaka@google.com>
From: Archie Pusaka <apusaka@google.com>
Date: Wed, 13 May 2026 12:09:37 +0800
X-Gm-Features: AVHnY4JLoKgB8_s0DX828rQSUrFk4smIcW2WIeJ7eCehNpIRr8SQtufULsmYrNM
Message-ID: <CAJQfnxG1P8oYEyR0geF-5Jo1Bde8KqeJ9YZiY4dUQvc6_cV4aw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Add decoding for Microsoft defined event
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi maintainers,

Could you review this patch? Thanks!

On Wed, 15 Apr 2026 at 15:40, Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> This adds decoders to MSFT LE monitor device event
> ---
>
>  monitor/msft.c   | 78 +++++++++++++++++++++++++++++++++++++++++++++++-
>  monitor/msft.h   |  1 +
>  monitor/packet.c | 44 ++++++++++++++++++++++-----
>  3 files changed, 115 insertions(+), 8 deletions(-)
>
> diff --git a/monitor/msft.c b/monitor/msft.c
> index 054f34006..d41f10d68 100644
> --- a/monitor/msft.c
> +++ b/monitor/msft.c
> @@ -41,6 +41,8 @@
>
>  #define COLOR_COMMAND          COLOR_BLUE
>  #define COLOR_COMMAND_UNKNOWN  COLOR_WHITE_BG
> +#define COLOR_EVENT            COLOR_MAGENTA
> +#define COLOR_EVENT_UNKNOWN    COLOR_WHITE_BG
>
>  static void null_cmd(const void *data, uint16_t size)
>  {
> @@ -299,10 +301,72 @@ const struct vendor_ocf *msft_vendor_ocf(void)
>         return &vendor_ocf_entry;
>  }
>
> +static void monitor_device_evt(const void *data, uint16_t size)
> +{
> +       const struct msft_evt_monitor_device *evt = data;
> +       const char *str_state;
> +
> +       packet_print_addr(NULL, evt->addr, evt->addr_type);
> +       print_field("Monitor handle: %u", evt->handle);
> +
> +       switch (evt->state) {
> +       case 0x00:
> +               str_state = "Stop monitoring";
> +               break;
> +       case 0x01:
> +               str_state = "Start monitoring";
> +               break;
> +       default:
> +               str_state = "Reserved";
> +               break;
> +       }
> +
> +       print_field("State: %s (0x%2.2x)", str_state, evt->state);
> +}
> +
> +static const struct {
> +       uint8_t code;
> +       const char *str;
> +       func_t evt_func;
> +} evt_table[] = {
> +       { 0x01, "RSSI Event" },
> +       { 0x02, "LE Monitor Device Event", monitor_device_evt },
> +       { }
> +};
> +
>  static void msft_evt(struct timeval *tv, uint16_t index,
>                         const void *data, uint8_t size)
>  {
> -       packet_hexdump(data, size);
> +       uint8_t code = get_u8(data);
> +       const char *code_color, *code_str = NULL;
> +       func_t code_func = NULL;
> +       int i;
> +
> +       for (i = 0; evt_table[i].str; i++) {
> +               if (evt_table[i].code == code) {
> +                       code_str = evt_table[i].str;
> +                       code_func = evt_table[i].evt_func;
> +                       break;
> +               }
> +       }
> +
> +       if (code_str) {
> +               if (code_func)
> +                       code_color = COLOR_EVENT;
> +               else
> +                       code_color = COLOR_EVENT_UNKNOWN;
> +       } else {
> +               code_color = COLOR_EVENT_UNKNOWN;
> +               code_str = "Unknown";
> +       }
> +
> +       print_indent(6, code_color, "", code_str, COLOR_OFF,
> +                                               " (0x%2.2x)", code);
> +
> +       if (code_func)
> +               code_func(data, size);
> +       else
> +               packet_hexdump(data + 1, size - 1);
>  }
>
>  static const struct vendor_evt vendor_evt_entry = {
> @@ -313,3 +377,15 @@ const struct vendor_evt *msft_vendor_evt(void)
>  {
>         return &vendor_evt_entry;
>  }
> +
> +bool msft_event_code_valid(uint8_t code)
> +{
> +       int i;
> +
> +       for (i = 0; evt_table[i].str; i++) {
> +               if (evt_table[i].code == code)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> diff --git a/monitor/msft.h b/monitor/msft.h
> index e6e3019be..ff6c28011 100644
> --- a/monitor/msft.h
> +++ b/monitor/msft.h
> @@ -187,3 +187,4 @@ struct vendor_evt;
>
>  const struct vendor_ocf *msft_vendor_ocf(void);
>  const struct vendor_evt *msft_vendor_evt(void);
> +bool msft_event_code_valid(uint8_t code);
> diff --git a/monitor/packet.c b/monitor/packet.c
> index ff0b1cac2..02f69dfca 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -450,8 +450,10 @@ void packet_set_fallback_manufacturer(uint16_t manufacturer)
>
>  void packet_set_msft_evt_prefix(const uint8_t *prefix, uint8_t len)
>  {
> -       if (index_current < MAX_INDEX && len < 8)
> +       if (index_current < MAX_INDEX && len < 8) {
>                 memcpy(index_list[index_current].msft_evt_prefix, prefix, len);
> +               index_list[index_current].msft_evt_len = len;
> +       }
>  }
>
>  static void cred_pid(struct ucred *cred, char *str, size_t len)
> @@ -4359,7 +4361,8 @@ static int addr2str(const uint8_t *addr, char *str)
>                         addr[5], addr[4], addr[3], addr[2], addr[1], addr[0]);
>  }
>
> -static int get_msft_opcode(uint16_t manufacturer) {
> +static int get_msft_opcode(uint16_t manufacturer)
> +{
>         switch (manufacturer) {
>         case COMPANY_ID_INTEL:
>                 return 0xFC1E;
> @@ -4374,7 +4377,23 @@ static int get_msft_opcode(uint16_t manufacturer) {
>         default:
>                 return BT_HCI_CMD_NOP;
>         }
> +}
> +
> +static bool msft_event_prefix_match(const void *data, int size)
> +{
> +       const void *prefix = index_list[index_current].msft_evt_prefix;
> +       int prefix_len = index_list[index_current].msft_evt_len;
> +
> +       /*
> +        * MSFT event has one byte of event code following the MSFT prefix.
> +        * We need to check the event code is valid, as it's possible for
> +        * a vendor to use the same MSFT prefix but for other events.
> +        */
> +       if (size >= prefix_len + 1 && !memcmp(prefix, data, prefix_len))
> +               return msft_event_code_valid(
> +                               ((const uint8_t *) data)[prefix_len]);
>
> +       return false;
>  }
>
>  void packet_monitor(struct timeval *tv, struct ucred *cred,
> @@ -10925,11 +10944,16 @@ static const struct vendor_ocf *current_vendor_ocf(uint16_t ocf)
>  }
>
>  static const struct vendor_evt *current_vendor_evt(const void *data,
> -                                                       int *consumed_size)
> +                                       uint8_t size, int *consumed_size)
>  {
>         uint16_t manufacturer;
>         uint8_t evt = *((const uint8_t *) data);
>
> +       if (msft_event_prefix_match(data, size)) {
> +               *consumed_size = index_list[index_current].msft_evt_len;
> +               return msft_vendor_evt();
> +       }
> +
>         /* A regular vendor event consumes 1 byte. */
>         *consumed_size = 1;
>
> @@ -10948,10 +10972,13 @@ static const struct vendor_evt *current_vendor_evt(const void *data,
>         return NULL;
>  }
>
> -static const char *current_vendor_evt_str(void)
> +static const char *current_vendor_evt_str(const void *data, uint8_t size)
>  {
>         uint16_t manufacturer;
>
> +       if (msft_event_prefix_match(data, size))
> +               return "Microsoft";
> +
>         if (index_current < MAX_INDEX)
>                 manufacturer = index_list[index_current].manufacturer;
>         else
> @@ -13547,17 +13574,20 @@ static void vendor_evt(struct timeval *tv, uint16_t index,
>         struct subevent_data vendor_data;
>         char vendor_str[150];
>         int consumed_size;
> -       const struct vendor_evt *vnd = current_vendor_evt(data, &consumed_size);
> +       const struct vendor_evt *vnd = current_vendor_evt(data, size,
> +                                                               &consumed_size);
>
>         if (vnd) {
> -               const char *str = current_vendor_evt_str();
> +               const char *str = current_vendor_evt_str(data, size);
>
>                 if (str) {
>                         snprintf(vendor_str, sizeof(vendor_str),
>                                                 "%s %s", str, vnd->str);
>                         vendor_data.str = vendor_str;
> -               } else
> +               } else {
>                         vendor_data.str = vnd->str;
> +               }
> +
>                 vendor_data.subevent = vnd->evt;
>                 vendor_data.func = vnd->evt_func;
>                 vendor_data.size = vnd->evt_size;
> --
> 2.54.0.rc0.605.g598a273b03-goog
>
