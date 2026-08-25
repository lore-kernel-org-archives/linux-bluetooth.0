Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02516392C2A
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787697288; cv=pass; b=Bt+TI5hPeUNkbzPTGw7MQVLQ/RnSP7UpwHT3hAn03oLdHxCHQCdLqf3KdpWBWMGBWyiEQWQL7R00m7epsxwf33IckLNDelf4rw1sf+AFEwGDnyEEvSrYFeb4xrlmO0as9zwY5AFFWZpWJr3wJ4UcWWpDqSn7EBnicDQ4E6ttoWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787697288; c=relaxed/simple;
	bh=uHwNMmSlKVOKOksOlOcpXVnUCxDFJchRpOP77Skivuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMa8s7Qk37jZMqua0VkS1C/iPxJRLCQjGcV4y4aSya9CRgXHQwIEu65lXKUp48FC556ey/Obut4pFx2JvrXs6euzFNRlZZ59WCEKSFnsu3XvIvNFq2XXwK+q0qZ4aEnse1KPZ/iV6AtD1umu67fxKQOukc2D7sAEBysIObWGJls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0n5/KPS; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0n5/KPS"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso266876e87.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 15:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787697285; cv=none;
        d=google.com; s=arc-20260327;
        b=mk8lFBKN3AWeanEkIY5r+x2IQhLZvL2UB/U0x+FgLM6A4fUXfsT8OdoKAhV6BdRLYh
         76fN1afJSP4XkwKqS5tkGngFHC+d/y1Thhz+N/Y9kmkdlxJCBWR/Yn6vBOTdisQK+REL
         H9AUsxMAoO2bTcFaNzW2b6SqdKPPzkqyIYDzokrt3wrlOOuur1RaOl+lrFOkYGcM2hhF
         48L0rYmNlPWWmpSFMVgIdhI4KZVxIgqttNayeclSpdiuFqXz0pUaSX0lsZGsIad0NUx6
         Ss0XU6lQgbw6K2u1ROZtp5yQPuORGjmIvWXvkDPkZKWqy6uGwlAYIibRTaG33wrx4nnB
         QJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fXwkt/yWHs7Hvlx6imrnaVKGrUmTwYMnYiutT7ypH+k=;
        fh=XgM0kStpErf8VURMxJj+yXywDMoRy9An41J7g9hqrCw=;
        b=Ok5ikx2DEQy6xFWWNVt9vvOkX6G4AzRDDQbA7++JIXgak8z1ELT3CDUnS8X25GayhJ
         H4TKOS96f6s97OgGtJoVIHnUTw8a99/E/7osObpkHZP/dHK1oIqSMrT40wxbWjiErpmW
         MzFvlkzBQukU7jO2KH2//85ePioLDrH0tCa05r3sFjaIyhNv5PA/G3gzq5i8Vg2hvfD3
         JpbbJZ8870sqyGsihPSYWQ/bSI32vCyfdfqA/Kl7j0FpO1dknsb2EGXIPS/8cB8xt5d7
         E64c6l8qAJ087LBWOjBxonvQpJXA4oCUYd7N1DNfuBkSQlX2InrACzEV4wg1OCpq0ul4
         1b3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787697285; x=1788302085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fXwkt/yWHs7Hvlx6imrnaVKGrUmTwYMnYiutT7ypH+k=;
        b=C0n5/KPSATqr2FtC9u54LCBLeyfPGqKg2SBpadJ8DzNbI55uut44R7UsZlUmQd+d37
         TrZ2r+UVbkBsxx5Z0gxlvJb50VlszB1Nkmh1DKtcBy3Wz7KO0ksTfAGR2+8oofXwsPXe
         tAHxYqgQr7YO2phD1odmeXBbLyl/SOBoGcH4n7y9w32U5AgeGSDBIFzMGQ/LOx0FIOUt
         VMeEnhAg0yKv2fWwdswvPAQHHR24NybahJuuA8FyiwnfUZR6sx2HoJ/CSEqQ02cDF/l+
         Rg1I5hQ0pmfJRBcoilf7YKZt3+ro6nC9+JZ3e60CoG94LGHWgvMXWTLUd6+MCaWudMAA
         6CFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787697285; x=1788302085;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fXwkt/yWHs7Hvlx6imrnaVKGrUmTwYMnYiutT7ypH+k=;
        b=J4T4Vqm3wa7QBdDfqQeFImn7rhjhwL54xyluXi7I8tNuW/1Euxvc1Y30PJV5aMwS/x
         sBgJCUQS1TQlFPm7Hj8TdbGIlbvPpzD/2KH0cDS70Ht9zeVFLobe0fcdzVqOomHOA6rD
         twsMAXUKSzNbU1Hj/JEqIQxLXGKfAkeo3WbwJmjmpYKZtPCSMNBjv2fn+K/kjBIhhmWv
         b9dKaHSw9X7y27zG1D/WpdGB9yQ+hKspbIGaiKmPyNk3camDX1e7dVlheqMDmKEPAxgt
         FDlAUygGQJ+mn9oan4USqOEk87bm6EuyN2ACxXCEGjzrwtqRmjl+Y+H+/Ubcx0tkx2WV
         PC7w==
X-Forwarded-Encrypted: i=1; AHgh+RrUfqLx5Jrx3snzOrnu9Bycp86CzB6reecBdDxjH/x+UYijdcHNBOju7NXxAMDuB+FsNvvceVxX1acjrn/2kK0=@vger.kernel.org
X-Gm-Message-State: AFuF++mW7+C8sprMzV849FgT4FaDlxP5BmjoeLeVJo6sVo10ZX7xb10C
	OYH/KCmJpkRC6jcQXu2JAH6uEQbUmeTin+dPnL1/43EdfDdSnQCbNm75XhdAiTVvNf6XEpcjQ/8
	p1RUkt3nTI0yNQatOqbq3ncKA6JAbrwaMNTXl
X-Gm-Gg: AR+sD10cWC5dRY+6qNOPfloMpPwqvJDHAD3LWUsRL/9KAXnb7jNKkq/WRiUSSahpsMk
	rccWpe0CvJ91m3mVXNszT1ZmYTXPBNK2eZMtN5JSRqnyLo7DkIylWy9T5OBldhn2jNvPQdFK7eZ
	rZLwax57rR6qUB8vgyji7Mz6MKL0Hxf89dSaAq2XWxQb2XTDeCWV0ynpKE6SVxCcuw4LW8lK7d1
	QmMNi2whBlqdN5B/JxVCvHvMorimgbIAVAsi9Xzfx34N0E/zs3j33kQMOklws6mHL7EL7JyE7kU
	3QOlSDdeqg9GGaqfuIoFN1FRdibfqij2ZBUViwDOhAcgd6cu63N3wmaoqG3kxnRinEesHWjC//Z
	1Kh4iJssg66qqvchLVOw1LqDj862jPJtLEKuR7TCz
X-Received: by 2002:a05:6512:1553:20b0:5b0:1ace:3bec with SMTP id
 2adb3069b0e04-5b4a9026cb0mr389552e87.10.1787697284756; Tue, 25 Aug 2026
 15:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717-bcm4356a3-bt-v1-1-ffa2d5233360@gmail.com>
In-Reply-To: <20260717-bcm4356a3-bt-v1-1-ffa2d5233360@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 25 Aug 2026 17:34:32 -0500
X-Gm-Features: AcwNN1VK7RMzNkBtg92tREfofFfPvpPoXK70Kb_n0azLYBDz6epHIa--hbSQeXo
Message-ID: <CALHNRZ9ofDZ61YW-ZN07sf8sZ6gx4n-8SusSR_vop7R_vqbGFA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth
To: webgeek1234@gmail.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 4:41=E2=80=AFPM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> From: Aaron Kling <webgeek1234@gmail.com>
>
> This patch adds the device ID for the bluetooth chip used in the
> Nvidia specific Broadcom BCM4356 PCI-E WiFi / UART BT chip.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/bluetooth/btbcm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 463d59890befe..14acea7325478 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -506,6 +506,7 @@ static const struct bcm_subver_table bcm_uart_subver_=
table[] =3D {
>         { 0x6606, "BCM4345C5"   },      /* 003.006.006 */
>         { 0x230f, "BCM4356A2"   },      /* 001.003.015 */
>         { 0x2310, "BCM4343A2"   },      /* 001.003.016 */
> +       { 0x2409, "BCM4356A3"   },      /* 001.004.009 */
>         { 0x220e, "BCM20702A1"  },      /* 001.002.014 */
>         { 0x420d, "BCM4349B1"   },      /* 002.002.013 */
>         { 0x420e, "BCM4349B1"   },      /* 002.002.014 */
>
> ---
> base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
> change-id: 20260717-bcm4356a3-bt-cd78cc0f42e8
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>

Are there any thoughts on this change? If not, could it get picked up pleas=
e?

Aaron
