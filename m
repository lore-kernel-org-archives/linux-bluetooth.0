Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ED676C87
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550479; cv=none; b=CaSI6OPu7H6sYSjKpVsMyVArj1SwovdyddBHUgICmbT31f5RMQahxBO8xp0yqkI0N4AHP2yjsyXerqSi8JBxFOTspOQlmFbaPtI5tYYYrcsZwqUXNWN7kfuQhHbSixajXhMuYL1b5FAQvbpD4c6evjIm2eEiDE/heM+Jd4Hdj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550479; c=relaxed/simple;
	bh=EyAZBkMpA/OK+QqBpmjgJctVZ+SPmxQuO6eZcI6rRvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SD2+R8WVTd1SEdpRFCPSNxHleTMQ6D958DR0jGFsxiY09a2dZ/8+zrqbkd7KV6WkB6EmlqxqEEo350OkiWKHzTgxOLd0IL69RwcZ0seBUsfNckePkDUUCYRKLLaQuAtJiARWOUlUKpkyloED4SxBl9lSRS0oatn3Ka3o5/hwng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRLagFQe; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRLagFQe"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so3549901276.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 09:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706550477; x=1707155277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EyAZBkMpA/OK+QqBpmjgJctVZ+SPmxQuO6eZcI6rRvU=;
        b=KRLagFQeMh116XvcakZsATyxbJAq2txfGgfMZzKdLK/rGCla6cElFH5+rul5+yvRh7
         U3ZE+doedqAyxruEbDJ56XwEaOcrU3bd1ForgVaOn3lTVpIDJwU/+AQsTMoWX5nbuZPO
         scaM3TcWWQqwYvt69+sopwkcDF8fbScf51ZiG5gpiASltxQg76MoR9oaVse5N2DlSOYE
         a7VC3x+mAXst66v3yjFWX5SkC2mM93sza9AyQtNQ/itRYaee3xxiiA9P1wmi1buy5yCi
         yBPE3RoORLXSiV4dT5Gtr1o7WKhE6PRSSmz20NOPzmVXr7YLLfpHQYiKRCD1MES7sdRd
         NSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550477; x=1707155277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyAZBkMpA/OK+QqBpmjgJctVZ+SPmxQuO6eZcI6rRvU=;
        b=HH2Bo4tlrgckrljT2MUXbTCF/tt1SbT+khYziYk4iXxKLe7RgpBS8FTvC47gi3bHcC
         Fb2+tX8iovSzggb1c9RdleLEz76d+MatHgngiRNekjGmR0I7GPHT6cRyW7ft+B5ncOHm
         3LNoL92xTKOmAV9QjkyvbI67sSmOBjM9jJdWjrZ/iOrS64jAVGSR8OKMwJy3TrmAa1Hn
         wqqGeLTo+rrIXbgF/ZEGB9vYYS0mNRhOKmCKNwiP8/bL21PqcmD/HopyJQScxQsI3TE+
         UqKJSF4BLeZtsV8+Ih1os1RZdLhWgdGF4vLCex875zNhrKcI0Ix9RTZELVzTUzriKNLq
         7hLA==
X-Gm-Message-State: AOJu0Yxsro5RzsOCRAOOJJlIWYtb+KYr0kzKWSpZIbJhutTfPHlFm0AS
	LcBPHrqOCRoqG1TcODQvvX1nMCLe2pbu2bvfDr99dSVYBv+AIcqtdN8W5NObjy0mkDa8Y4SKuA9
	utBfNO0dYAMJRoLm9Y04SDYQqkeMJFvif
X-Google-Smtp-Source: AGHT+IH2PAWKPyrjhZgLxlFneyIjImbpP3klyEiD/un8DvMA9zqMML/trQ8sVuO021rWisZpmk/cipRdUSsZXtzkyFc=
X-Received: by 2002:a5b:41:0:b0:dc6:1a0d:6746 with SMTP id e1-20020a5b0041000000b00dc61a0d6746mr3860218ybp.51.1706550477048;
 Mon, 29 Jan 2024 09:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
 <20240129-rm-ext-plugins-v4-7-bfd1e08c7f99@gmail.com> <a97398e2-856b-4034-b8d3-e65f54b2bb17@molgen.mpg.de>
 <CABBYNZJY0-hfvUEM101fE4WogdH_cosP65_ai=QUKUcs57JFUA@mail.gmail.com>
In-Reply-To: <CABBYNZJY0-hfvUEM101fE4WogdH_cosP65_ai=QUKUcs57JFUA@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 29 Jan 2024 17:47:45 +0000
Message-ID: <CACvgo50SYgrKk5=RmzA2AqAhQZFENmTQqP62cOEoN7dpmKMN1A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 7/8] bluetoothd: change plugin loading alike obexd
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Emil Velikov <emil.velikov@collabora.com>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello team,

On Mon, 29 Jan 2024 at 16:22, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:

>
> To me it sounds quite clear that he is refering to the fact that obexd
> prints it a little differently so he is just trying to align the
> behavior of the daemons.
>

Precisely - we do basic alignment across the two daemons. Both in
terms of code as well as logging pattern.
Although if that's not wanted, please drop this patch. There's a
reason why I kept it near the end of the series ;-)

Re-sending the series for the comma in 8/8 seems excessive IMHO. If
there are other concerns, I'd be happy to respin the lot.
Otherwise I think it's simpler if Luiz fixes it on applying.

Thanks
Emil
